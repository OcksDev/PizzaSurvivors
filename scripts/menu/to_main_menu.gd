extends Button

@export var menu_scene = "res://scenes/menu/main_menu.tscn"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_pressed() -> void:
	MenuPageChangeSound.play();
	get_tree().paused = false;
	get_tree().change_scene_to_file(menu_scene);
