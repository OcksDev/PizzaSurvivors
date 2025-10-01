extends CanvasLayer
@export var game_scene : Resource
@export var credits_scene : Resource
@export var changelog_scene : Resource

@export var MENU_MUSIC : Resource

func _ready() -> void:
	# If the music player is not playing or if the music playing is not the menu music, play the menu music
	if not MusicPlayer.stream or MusicPlayer.stream.resource_path != MENU_MUSIC.resource_path:
		MusicPlayer.stream = MENU_MUSIC
		MusicPlayer.play()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene);
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	MenuPageChangeSound.play();
	get_tree().change_scene_to_packed(credits_scene);
	pass # Replace with function body.


func _on_changelog_pressed() -> void:
	MenuPageChangeSound.play();
	get_tree().change_scene_to_packed(changelog_scene);
	pass # Replace with function body.


func _on_rahhh_pressed() -> void:
	get_child(0).color = Color(randf(), randf(), randf(), 1.0)
	%AudioStreamPlayer2D.play();
	pass # Replace with function body.


func _on_close_game_button_pressed() -> void:
	get_tree().quit()
