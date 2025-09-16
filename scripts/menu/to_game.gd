extends Button

@export var game_scene = "res://scenes/game/game.tscn"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_pressed() -> void:
	get_tree().paused = false;
	get_tree().reload_current_scene()
