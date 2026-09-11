extends Node
## Arm als Turm auf dem Roboter: zwei Glieder, eigene Zwei-Glieder-IK, Hover-Zielen, Schlag im Takt,
## Brechen im Wucht-Radius, Brocken und Staub. Der Code dreht nur Joint_arm_1 / Joint_arm_2.

@export_group("Arm")
## Reichweite der Werkzeugspitze ab Schulter (m).
@export var reach: float = 1.2
## Wie zügig die Spitze ihrem Ziel folgt (~1/s).
@export var tip_smoothing: float = 14.0

@export_group("Schlag")
## Dauer eines Schlagzyklus (s): Ausholen und Schlag.
@export var strike_period: float = 0.37
## Anteil des Zyklus fürs Ausholen.
@export_range(0.1, 0.9) var windup_fraction: float = 0.55
## Werkzeugkraft gegen die Bindung der Teile.
@export var force: float = 3.0
## Wucht-Radius um das Ziel (m); Teile darin werden nach Nähe gewichtet getroffen.
@export var impact_radius: float = 0.35
## Wie viel Radius (m) ein Teil pro Einheit chip verliert.
@export var chip_scale: float = 0.05
## Hitstop in Frames.
@export var hitstop_frames: int = 3
## Kamerawackeln beim Treffer.
@export var shake_amount: float = 0.03

@export_group("Brocken")
## Brocken pro m³ abgebrochenem Volumen.
@export var chunks_per_volume: float = 250.0
@export var chunks_max_per_hit: int = 6
@export var chunk_radius: float = 0.05
@export var chunk_speed: float = 1.6

@onready var robot: CharacterBody3D = get_parent()
@onready var body: Node3D = robot.get_node("Body")
@onready var joint_1: Node3D = body.get_node("Joint_arm_1")
@onready var joint_2: Node3D = joint_1.get_node("Joint_arm_2")
@onready var tool_tip: Node3D = joint_2.get_node("Tool_tip")
@onready var target_ring: MeshInstance3D = $TargetRing

var link_1: float
var link_2: float

var target_part: StaticBody3D = null
var target_in_reach: bool = false
var _strike_point: Vector3 = Vector3.ZERO
var _cycle: float = 0.0
var _striking: bool = false
var _tip_goal: Vector3 = Vector3.ZERO   # Welt
var _tip_pos: Vector3 = Vector3.ZERO    # Welt, geglättet
var _hitstop_left: int = 0

const RING_IN := Color(1.0, 0.94, 0.78, 0.9)
const RING_OUT := Color(1.0, 0.55, 0.4, 0.7)

var _chunk_mesh: SphereMesh
var _chunk_shape: SphereShape3D
var _chunk_material: StandardMaterial3D


func _ready() -> void:
	# Hitstop pausiert den Baum; dieser Node zählt die Frames trotzdem weiter.
	process_mode = Node.PROCESS_MODE_ALWAYS
	link_1 = joint_2.position.length()
	link_2 = tool_tip.position.length()
	_tip_pos = _rest_point()
	_chunk_mesh = SphereMesh.new()
	_chunk_mesh.radius = chunk_radius
	_chunk_mesh.height = chunk_radius * 2.0
	_chunk_mesh.radial_segments = 8
	_chunk_mesh.rings = 4
	_chunk_shape = SphereShape3D.new()
	_chunk_shape.radius = chunk_radius
	_chunk_material = StandardMaterial3D.new()
	_chunk_material.albedo_color = Color(0.40, 0.30, 0.21)
	_chunk_material.roughness = 0.95


func _process(delta: float) -> void:
	# Hitstop: Baum pausiert, Frames zählen weiter.
	if _hitstop_left > 0:
		_hitstop_left -= 1
		if _hitstop_left == 0:
			get_tree().paused = false
		return

	_update_target()
	_update_strike(delta)
	_tip_pos = _tip_pos.lerp(_tip_goal, 1.0 - exp(-tip_smoothing * delta))
	_solve_ik(_tip_pos)
	_update_ring()


func _shoulder() -> Vector3:
	return joint_1.global_position


func _rest_point() -> Vector3:
	# Locker vor dem Roboter, etwas erhoben.
	return body.to_global(Vector3(0.0, 0.32, -0.28))


func _update_target() -> void:
	target_part = null
	target_in_reach = false
	var camera := get_viewport().get_camera_3d()
	if camera == null:
		return
	var mouse := get_viewport().get_mouse_position()
	var from := camera.project_ray_origin(mouse)
	var to := from + camera.project_ray_normal(mouse) * 100.0
	var query := PhysicsRayQueryParameters3D.create(from, to, 4)
	var hit := robot.get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return
	var part := hit.collider as StaticBody3D
	if part == null or not part.is_in_group("lump_parts"):
		return
	target_part = part
	# Schlagpunkt: Oberfläche des Teils, der Schulter zugewandt.
	var shoulder := _shoulder()
	var toward := (shoulder - part.global_position).normalized()
	_strike_point = part.global_position + toward * part.radius * 0.8
	target_in_reach = shoulder.distance_to(_strike_point) <= reach


func _update_strike(delta: float) -> void:
	if not target_in_reach:
		_striking = false
		_cycle = 0.0
		_tip_goal = _rest_point()
		return
	_striking = true
	_cycle += delta / strike_period
	var away := (_shoulder() - _strike_point).normalized()
	var windup := _strike_point + away * 0.25 + Vector3.UP * 0.30
	if _cycle < windup_fraction:
		_tip_goal = windup
	else:
		_tip_goal = _strike_point
	if _cycle >= 1.0:
		_cycle -= 1.0
		_tip_pos = _strike_point
		_hit()


func _hit() -> void:
	if target_part == null or not is_instance_valid(target_part):
		return
	var center := _strike_point
	var space := robot.get_world_3d().direct_space_state
	var shape := SphereShape3D.new()
	shape.radius = impact_radius
	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = shape
	query.transform = Transform3D(Basis.IDENTITY, center)
	query.collision_mask = 4
	var hits := space.intersect_shape(query, 32)

	var removed_volume := 0.0
	var any_chip := false
	var target_too_hard := false
	for h in hits:
		var part := h.collider as StaticBody3D
		if part == null or not part.is_in_group("lump_parts"):
			continue
		var d: float = center.distance_to(part.global_position) - part.radius
		var near := clampf(1.0 - maxf(d, 0.0) / impact_radius, 0.0, 1.0)
		if part == target_part:
			near = 1.0
		var chip: float = (force - part.bind) * near
		if chip <= 0.0:
			if part == target_part:
				target_too_hard = true
			continue
		any_chip = true
		removed_volume += part.shrink(chip * chip_scale)

	_hitstop_left = hitstop_frames
	get_tree().paused = true
	var cam := get_viewport().get_camera_3d()
	if cam and cam.get_parent().has_method("shake"):
		cam.get_parent().shake(shake_amount * (1.6 if any_chip else 0.7))

	if target_too_hard and not any_chip:
		_spawn_particles(center, Color(1.0, 0.9, 0.6), 10, 2.2, 0.25, 0.012)
		get_tree().call_group("hud", "show_message", "Zu hart für dieses Werkzeug.")
	else:
		_spawn_particles(center, Color(0.45, 0.36, 0.27, 0.7), 14, 0.9, 0.6, 0.03)
		_spawn_chunks(center, removed_volume)


func _spawn_chunks(center: Vector3, volume: float) -> void:
	var n := mini(int(ceil(volume * chunks_per_volume)), chunks_max_per_hit)
	var away := (_shoulder() - center).normalized()
	var world := robot.get_tree().current_scene
	for i in range(n):
		var chunk := RigidBody3D.new()
		chunk.name = "Chunk"
		chunk.add_to_group("chunks")
		chunk.collision_layer = 2
		chunk.collision_mask = 1 | 2
		chunk.mass = 0.05
		chunk.linear_damp = 0.5
		chunk.angular_damp = 1.0
		chunk.can_sleep = true
		var mi := MeshInstance3D.new()
		mi.mesh = _chunk_mesh
		mi.material_override = _chunk_material
		mi.scale = Vector3.ONE * randf_range(0.7, 1.2)
		chunk.add_child(mi)
		var cs := CollisionShape3D.new()
		cs.shape = _chunk_shape
		chunk.add_child(cs)
		world.add_child(chunk)
		chunk.global_position = center + Vector3(randf_range(-0.05, 0.05), 0.05, randf_range(-0.05, 0.05))
		var dir := (away + Vector3(randf_range(-0.6, 0.6), randf_range(0.6, 1.2), randf_range(-0.6, 0.6))).normalized()
		chunk.linear_velocity = dir * chunk_speed * randf_range(0.7, 1.3)
		chunk.angular_velocity = Vector3(randf_range(-6, 6), randf_range(-6, 6), randf_range(-6, 6))


func _spawn_particles(center: Vector3, color: Color, amount: int, speed: float, lifetime: float, size: float) -> void:
	var p := CPUParticles3D.new()
	p.one_shot = true
	p.emitting = true
	p.amount = amount
	p.lifetime = lifetime
	p.explosiveness = 1.0
	p.direction = Vector3.UP
	p.spread = 70.0
	p.initial_velocity_min = speed * 0.5
	p.initial_velocity_max = speed
	p.gravity = Vector3(0, -3.0, 0)
	p.scale_amount_min = 0.6
	p.scale_amount_max = 1.2
	p.color = color
	var m := SphereMesh.new()
	m.radius = size
	m.height = size * 2.0
	m.radial_segments = 6
	m.rings = 3
	var mat := StandardMaterial3D.new()
	mat.vertex_color_use_as_albedo = true
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	m.material = mat
	p.mesh = m
	robot.get_tree().current_scene.add_child(p)
	p.global_position = center
	p.finished.connect(p.queue_free)


func _solve_ik(tip_world: Vector3) -> void:
	# Ziel in den Raum von Joint_arm_1s Elternteil (Body) holen, relativ zur Schulter.
	var t: Vector3 = body.to_local(tip_world) - joint_1.position
	var yaw := atan2(-t.x, -t.z)
	var h := Vector2(t.x, t.z).length()
	var v := t.y
	var d := clampf(sqrt(h * h + v * v), 0.05, link_1 + link_2 - 0.01)
	var phi := atan2(v, h)
	var a1 := acos(clampf((link_1 * link_1 + d * d - link_2 * link_2) / (2.0 * link_1 * d), -1.0, 1.0))
	var a2 := acos(clampf((link_1 * link_1 + link_2 * link_2 - d * d) / (2.0 * link_1 * link_2), -1.0, 1.0))
	# Ellbogen oben: Schulter hebt um phi + a1, Ellbogen knickt nach unten.
	joint_1.basis = Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, phi + a1)
	joint_2.basis = Basis(Vector3.RIGHT, -(PI - a2))


func _update_ring() -> void:
	if target_part == null or not is_instance_valid(target_part):
		target_ring.visible = false
		return
	target_ring.visible = true
	target_ring.global_position = target_part.global_position
	var r: float = target_part.radius * 1.15
	target_ring.scale = Vector3(r, r, r)
	(target_ring.material_override as StandardMaterial3D).albedo_color = RING_IN if target_in_reach else RING_OUT
