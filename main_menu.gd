extends CanvasLayer
@export var game_scene : Resource
@export var credits_scene : Resource
@export var changelog_scene : Resource


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene);
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits_scene);
	pass # Replace with function body.


func _on_changelog_pressed() -> void:
	get_tree().change_scene_to_packed(changelog_scene);
	pass # Replace with function body.


func _on_rahhh_pressed() -> void:
	get_child(0).color = Color(randf(), randf(), randf(), 1.0)
	pass # Replace with function body.
