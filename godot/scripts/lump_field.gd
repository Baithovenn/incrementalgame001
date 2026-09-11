extends Node3D
## Prozedurales Klumpenfeld. Alles voller Klumpen, keine Gänge, freier Hof um den Ursprung (Basis).
## Jeder Klumpen: Traube aus Kugeln (eigene StaticBody3D mit "bind"), Kern in der Mitte dunkler.
## Klumpen weiter von der Basis weg sind härter.

## Seed für reproduzierbare Felder.
@export var seed: int = 1:
	set(v):
		seed = v
		if is_inside_tree():
			generate()
## Kantenlänge des Feldes (m), mittig um den Ursprung.
@export var field_size: float = 20.0
## Freier Hof um die Basis (m).
@export var base_clear_radius: float = 3.0
## Rasterabstand der Klumpen (m); kleiner = dichter.
@export var lump_spacing: float = 1.5
## Zufälliger Versatz der Klumpen im Raster (m).
@export var lump_jitter: float = 0.35
## Teile pro Klumpen.
@export var parts_min: int = 8
@export var parts_max: int = 16
## Radius eines Teils (m).
@export var part_radius_min: float = 0.22
@export var part_radius_max: float = 0.42
## Wie weit die Teile um die Klumpenmitte streuen (m).
@export var cluster_radius: float = 0.6
## Bindung am Hofrand und am Feldrand.
@export var bind_near: float = 1.0
@export var bind_far: float = 5.0

const MESH_VARIANTS := 6
const PALETTE := [
	Color(0.36, 0.26, 0.17),
	Color(0.32, 0.23, 0.16),
	Color(0.39, 0.29, 0.20),
	Color(0.30, 0.22, 0.17),
	Color(0.34, 0.27, 0.19),
]
const CORE_COLOR := Color(0.21, 0.15, 0.10)

var _rng := RandomNumberGenerator.new()
var _meshes: Array[Mesh] = []
var _materials: Array[StandardMaterial3D] = []
var _core_material: StandardMaterial3D
var part_count: int = 0
var lump_count: int = 0


func _ready() -> void:
	generate()


func generate() -> void:
	for c in get_children():
		remove_child(c)
		c.queue_free()
	_rng.seed = seed
	_build_meshes()
	_build_materials()
	part_count = 0
	lump_count = 0

	var half := field_size * 0.5
	var far_dist := sqrt(2.0) * half
	var n := int(field_size / lump_spacing)
	for ix in range(n):
		for iz in range(n):
			var x := -half + (ix + 0.5) * lump_spacing + _rng.randf_range(-lump_jitter, lump_jitter)
			var z := -half + (iz + 0.5) * lump_spacing + _rng.randf_range(-lump_jitter, lump_jitter)
			var center := Vector3(x, 0.0, z)
			var dist := center.length()
			if dist < base_clear_radius + cluster_radius:
				continue
			var t := clampf((dist - base_clear_radius) / (far_dist - base_clear_radius), 0.0, 1.0)
			var bind := lerpf(bind_near, bind_far, t)
			_spawn_lump(center, bind)


func _spawn_lump(center: Vector3, bind: float) -> void:
	var lump := Node3D.new()
	lump.name = "Lump_%d" % lump_count
	lump.position = center
	add_child(lump)
	lump_count += 1

	var count := _rng.randi_range(parts_min, parts_max)
	# Kern in der Mitte, etwas größer und härter.
	_spawn_part(lump, Vector3.ZERO, part_radius_max * 1.05, bind * 1.6, true)
	for i in range(count - 1):
		var angle := _rng.randf_range(0.0, TAU)
		var r := cluster_radius * sqrt(_rng.randf())
		var offset := Vector3(cos(angle) * r, 0.0, sin(angle) * r)
		var radius := _rng.randf_range(part_radius_min, part_radius_max)
		var part_bind := bind * _rng.randf_range(0.8, 1.2)
		_spawn_part(lump, offset, radius, part_bind, false)


func _spawn_part(lump: Node3D, offset: Vector3, radius: float, bind: float, is_core: bool) -> void:
	var part := StaticBody3D.new()
	part.set_script(preload("res://scripts/lump_part.gd"))
	part.name = "Core" if is_core else "Part_%d" % lump.get_child_count()
	part.bind = bind
	part.is_core = is_core
	# Teile sitzen etwas im Boden, damit die Traube lehmig aufliegt.
	part.position = offset + Vector3(0.0, radius * 0.6, 0.0)
	part.rotation.y = _rng.randf_range(0.0, TAU)
	lump.add_child(part)

	var mesh := MeshInstance3D.new()
	mesh.name = "Mesh"
	mesh.mesh = _meshes[_rng.randi_range(0, MESH_VARIANTS - 1)]
	# Abgeflacht und leicht ungleich, damit es nicht perlig wirkt.
	mesh.scale = Vector3(radius * _rng.randf_range(0.95, 1.15), radius * _rng.randf_range(0.65, 0.8), radius * _rng.randf_range(0.95, 1.15))
	mesh.material_override = _core_material if is_core else _materials[_rng.randi_range(0, _materials.size() - 1)]
	part.add_child(mesh)

	var shape := CollisionShape3D.new()
	shape.name = "CollisionShape3D"
	var sphere := SphereShape3D.new()
	sphere.radius = radius * 0.95
	shape.shape = sphere
	part.add_child(shape)
	part_count += 1


func _build_meshes() -> void:
	_meshes.clear()
	var noise := FastNoiseLite.new()
	noise.frequency = 1.4
	for v in range(MESH_VARIANTS):
		noise.seed = seed * 100 + v
		var sphere := SphereMesh.new()
		sphere.radius = 1.0
		sphere.height = 2.0
		sphere.radial_segments = 14
		sphere.rings = 8
		var arrays := sphere.get_mesh_arrays()
		var verts: PackedVector3Array = arrays[Mesh.ARRAY_VERTEX]
		for i in range(verts.size()):
			var p := verts[i]
			var d := 1.0 + noise.get_noise_3d(p.x, p.y, p.z) * 0.45
			verts[i] = p * d
		arrays[Mesh.ARRAY_VERTEX] = verts
		var st := SurfaceTool.new()
		st.create_from_arrays(arrays, Mesh.PRIMITIVE_TRIANGLES)
		st.deindex()
		st.index()
		st.generate_normals()
		_meshes.append(st.commit())


func _build_materials() -> void:
	_materials.clear()
	for c in PALETTE:
		var m := StandardMaterial3D.new()
		m.albedo_color = c
		m.roughness = 0.95
		_materials.append(m)
	_core_material = StandardMaterial3D.new()
	_core_material.albedo_color = CORE_COLOR
	_core_material.roughness = 0.9
