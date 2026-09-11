extends Label
## Kurze Meldung oben in der Mitte, blendet nach kurzer Zeit aus. Gruppe "hud".

@export var hold_time: float = 0.9

var _left: float = 0.0


func _ready() -> void:
	text = ""
	modulate.a = 0.0


func show_message(msg: String) -> void:
	text = msg
	_left = hold_time
	modulate.a = 1.0


func _process(delta: float) -> void:
	if _left <= 0.0:
		return
	_left -= delta
	modulate.a = clampf(_left / 0.3, 0.0, 1.0)
