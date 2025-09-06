extends Button

@export var menu_scene = "res://main_menu.tscn"

func _on_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene);
