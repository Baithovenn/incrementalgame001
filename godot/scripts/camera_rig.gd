@tool
extends Node3D
## Kamera schräg von oben mit festem Winkel, Perspektive. Dreht nie mit.
## Der Rig folgt einem Zielpunkt = Roboterposition + Geschwindigkeit * lookahead_time.
## Der Zielpunkt ist selbst geglättet, damit er beim Loslassen zurückgleitet statt zu schnappen.
## Mausrad zoomt (nur für den Test) zwischen zoom_min und zoom_max.

## Was die Kamera verfolgt (normalerweise der Hauptroboter, ein CharacterBody3D).
@export var target: Node3D
## Neigung nach unten in Grad. 90 = senkrecht von oben, 0 = waagerecht.
@export_range(10.0, 89.0, 1.0) var pitch_degrees: float = 35.0:
	set(v):
		pitch_degrees = v
		_update_camera()
## Drehung des Blicks um die Hochachse in Grad (0 = Blick nach -Z, also Bildschirm-oben ist Welt -Z).
@export_range(-180.0, 180.0, 1.0) var yaw_degrees: float = 0.0:
	set(v):
		yaw_degrees = v
		_update_camera()
## Höhe der Kamera über dem Boden in Metern. Standard nah: Roboter ≈ 1/10 der Bildhöhe.
@export_range(1.0, 40.0, 0.1) var height: float = 2.5:
	set(v):
		height = v
		_update_camera()
## Öffnungswinkel (vertikal).
@export_range(20.0, 90.0, 1.0) var fov: float = 45.0:
	set(v):
		fov = v
		_update_camera()

@export_group("Folgen")
## Wie zügig der Rig dem Zielpunkt nachzieht (größer = strammer, ~1/s).
@export var follow_speed: float = 6.0
## Vorlauf: Zielpunkt liegt um Geschwindigkeit * lookahead_time vor dem Roboter (s).
@export var lookahead_time: float = 0.8
## Wie zügig der Zielpunkt selbst nachzieht (größer = schneller, ~1/s).
@export var lookahead_smoothing: float = 3.0

@export_group("Zoom (Test)")
## Mausrad-Zoom: kleinste Höhe.
@export var zoom_min: float = 2.0
## Mausrad-Zoom: größte Höhe.
@export var zoom_max: float = 10.0
## Höhenänderung pro Rad-Klick (m).
@export var zoom_step: float = 0.4

@onready var camera: Camera3D = $Camera3D

var _look_point: Vector3 = Vector3.ZERO


func _ready() -> void:
	_update_camera()
	if not Engine.is_editor_hint() and target:
		_look_point = _ground(target.global_position)
		global_position = _look_point


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			height = clampf(height - zoom_step, zoom_min, zoom_max)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			height = clampf(height + zoom_step, zoom_min, zoom_max)


func _process(delta: float) -> void:
	if Engine.is_editor_hint() or target == null:
		return
	var velocity := Vector3.ZERO
	if target is CharacterBody3D:
		velocity = (target as CharacterBody3D).velocity
	var goal := _ground(target.global_position + velocity * lookahead_time)
	_look_point = _look_point.lerp(goal, 1.0 - exp(-lookahead_smoothing * delta))
	global_position = global_position.lerp(_look_point, 1.0 - exp(-follow_speed * delta))


func _ground(p: Vector3) -> Vector3:
	return Vector3(p.x, 0.0, p.z)


func _update_camera() -> void:
	if camera == null:
		return
	var pitch := deg_to_rad(pitch_degrees)
	var yaw := deg_to_rad(yaw_degrees)
	var back := height / tan(pitch)
	# Kamera steht "hinter" dem Rig-Ursprung (Richtung +Z bei yaw 0) und schaut auf ihn.
	camera.position = Vector3(sin(yaw) * back, height, cos(yaw) * back)
	camera.look_at_from_position(camera.position, Vector3.ZERO, Vector3.UP)
	camera.projection = Camera3D.PROJECTION_PERSPECTIVE
	camera.fov = fov
