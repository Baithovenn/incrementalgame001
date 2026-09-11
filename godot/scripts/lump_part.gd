extends StaticBody3D
## Ein Teil eines Klumpens: eine Kugel mit Bindung (Härte).
## Schrumpft sichtbar, wenn ein Schlag die Bindung übertrifft; unter min_radius verschwindet es.

## Bindung: wie fest das Teil am Klumpen hängt. Werkzeugkraft muss darüber liegen.
@export var bind: float = 1.0
## Kern des Klumpens (härter, in der Mitte).
@export var is_core: bool = false
## Aktueller Radius (m).
@export var radius: float = 0.3
## Unter diesem Radius ist das Teil weg.
@export var min_radius: float = 0.09

var _mesh_ratio: Vector3 = Vector3.ONE  # Mesh-Skalierung pro Meter Radius


func setup(r: float, mesh_scale: Vector3) -> void:
	radius = r
	_mesh_ratio = mesh_scale / r
	_apply_radius()


## Schrumpft um `amount` Meter Radius. Gibt das entfernte Volumen (m³) zurück.
## Bei Unterschreiten von min_radius wird das Teil entfernt (Kollision frei).
func shrink(amount: float) -> float:
	var old_r := radius
	radius = maxf(radius - amount, 0.0)
	var removed := _volume(old_r) - _volume(radius)
	if radius < min_radius:
		removed = _volume(old_r)
		radius = 0.0
		$CollisionShape3D.disabled = true
		queue_free()
	else:
		_apply_radius()
	return removed


func _apply_radius() -> void:
	$Mesh.scale = _mesh_ratio * radius
	($CollisionShape3D.shape as SphereShape3D).radius = radius * 0.95


static func _volume(r: float) -> float:
	return 4.0 / 3.0 * PI * r * r * r
