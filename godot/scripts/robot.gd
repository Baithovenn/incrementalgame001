extends CharacterBody3D
## Hauptroboter: WASD direkt auf der XZ-Ebene, mit Trägheit.
## Der Roboter dreht sich träge in Fahrtrichtung; Bewegung ist unabhängig von der Blickrichtung.

@export_group("Fahren")
## Höchsttempo in m/s.
@export var max_speed: float = 2.5
## Beschleunigung in m/s², wenn eine Taste gehalten wird.
@export var acceleration: float = 5.0
## Abbremsen in m/s², wenn keine Taste gehalten wird.
@export var deceleration: float = 7.0
## Wie schnell sich der Roboter in Fahrtrichtung dreht (größer = schneller, ~1/s).
@export var turn_speed: float = 6.0

@export_group("Schweben")
## Ruhehöhe der Körpermitte über dem Boden (m).
@export var hover_height: float = 0.10
## Auf-und-Ab-Ausschlag (m).
@export var hover_amplitude: float = 0.015
## Auf-und-Ab-Frequenz (Hz).
@export var hover_frequency: float = 0.8

## Halbe Kantenlänge des Bodens; der Roboter bleibt innerhalb.
@export var world_half_size: float = 19.5

@onready var body: Node3D = $Body

var _hover_time: float = 0.0


func _physics_process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	# Bildschirm-oben ist Welt -Z, Bildschirm-rechts ist Welt +X (Kamera dreht nicht mit).
	var wish_dir := Vector3(input.x, 0.0, input.y)

	var horizontal := Vector3(velocity.x, 0.0, velocity.z)
	if wish_dir.length_squared() > 0.0:
		horizontal = horizontal.move_toward(wish_dir * max_speed, acceleration * delta)
	else:
		horizontal = horizontal.move_toward(Vector3.ZERO, deceleration * delta)

	velocity = Vector3(horizontal.x, 0.0, horizontal.z)
	move_and_slide()

	position.x = clampf(position.x, -world_half_size, world_half_size)
	position.z = clampf(position.z, -world_half_size, world_half_size)
	position.y = 0.0

	# Träge in Fahrtrichtung drehen, sobald man wirklich fährt.
	if horizontal.length() > 0.2:
		var target_yaw := atan2(-horizontal.x, -horizontal.z)
		rotation.y = lerp_angle(rotation.y, target_yaw, 1.0 - exp(-turn_speed * delta))


func _process(delta: float) -> void:
	_hover_time += delta
	body.position.y = hover_height + sin(_hover_time * TAU * hover_frequency) * hover_amplitude
