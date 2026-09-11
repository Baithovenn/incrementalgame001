extends Node3D
## Hauptszene. Für den automatischen Check ohne Spieler:
##   --screenshot=<pfad>  speichert nach 270 Frames ein Bild und beendet das Spiel.
##   --drive              hält dabei W+D gedrückt, damit man Fahrt und Drehung sieht.

var _screenshot_path: String = ""
var _drive: bool = false
var _frames: int = 0


func _ready() -> void:
	for arg in OS.get_cmdline_user_args():
		if arg.begins_with("--screenshot="):
			_screenshot_path = arg.trim_prefix("--screenshot=")
		elif arg == "--drive":
			_drive = true


func _process(_delta: float) -> void:
	if _screenshot_path.is_empty():
		return
	_frames += 1
	if _drive and _frames == 10:
		Input.action_press("move_forward")
		Input.action_press("move_right")
	if _drive and _frames == 250:
		Input.action_release("move_forward")
		Input.action_release("move_right")
	if _frames == 270:
		var robot: Node3D = $Robot
		print("robot pos=%s yaw=%.1f deg dist=%.2f" % [robot.global_position, rad_to_deg(robot.rotation.y), robot.global_position.length()])
		var field := $LumpField
		print("field: %d lumps, %d parts" % [field.lump_count, field.part_count])
		var img := get_viewport().get_texture().get_image()
		var err := img.save_png(_screenshot_path)
		print("screenshot -> %s (%d)" % [_screenshot_path, err])
		get_tree().quit()
