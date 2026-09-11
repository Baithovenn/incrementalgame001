@tool
extends Node3D
## Kamera schräg von oben mit festem Winkel. Der Rig folgt dem Ziel weich, dreht nie mit.
## Im Editor sichtbar: Winkel, Höhe und Projektion wirken sofort.

## Was die Kamera verfolgt (normalerweise der Hauptroboter).
@export var target: Node3D
## Neigung nach unten in Grad. 90 = senkrecht von oben, 0 = waagerecht.
@export_range(10.0, 89.0, 1.0) var pitch_degrees: float = 55.0:
	set(v):
		pitch_degrees = v
		_update_camera()
## Drehung des Blicks um die Hochachse in Grad (0 = Blick nach -Z, also Bildschirm-oben ist Welt -Z).
@export_range(-180.0, 180.0, 1.0) var yaw_degrees: float = 0.0:
	set(v):
		yaw_degrees = v
		_update_camera()
## Höhe der Kamera über dem Boden in Metern.
@export_range(2.0, 40.0, 0.5) var height: float = 5.0:
	set(v):
		height = v
		_update_camera()
## Orthografisch statt perspektivisch.
@export var orthographic: bool = false:
	set(v):
		orthographic = v
		_update_camera()
## Bildhöhe in Metern bei orthografischer Projektion.
@export_range(2.0, 40.0, 0.5) var ortho_size: float = 10.0:
	set(v):
		ortho_size = v
		_update_camera()
## Öffnungswinkel bei Perspektive.
@export_range(20.0, 90.0, 1.0) var fov: float = 45.0:
	set(v):
		fov = v
		_update_camera()
## Wie zügig der Rig dem Ziel nachzieht (größer = strammer, ~1/s).
@export var follow_speed: float = 4.0

@onready var camera: Camera3D = $Camera3D


func _ready() -> void:
	_update_camera()
	if not Engine.is_editor_hint() and target:
		global_position = target.global_position


func _process(delta: float) -> void:
	if Engine.is_editor_hint() or target == null:
		return
	var goal := target.global_position
	goal.y = 0.0
	global_position = global_position.lerp(goal, 1.0 - exp(-follow_speed * delta))


func _update_camera() -> void:
	if camera == null:
		return
	var pitch := deg_to_rad(pitch_degrees)
	var yaw := deg_to_rad(yaw_degrees)
	var back := height / tan(pitch)
	# Kamera steht "hinter" dem Rig-Ursprung (Richtung +Z bei yaw 0) und schaut auf ihn.
	var offset := Vector3(sin(yaw) * back, height, cos(yaw) * back)
	camera.position = offset
	camera.look_at_from_position(camera.position, Vector3.ZERO, Vector3.UP)
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL if orthographic else Camera3D.PROJECTION_PERSPECTIVE
	camera.size = ortho_size
	camera.fov = fov
