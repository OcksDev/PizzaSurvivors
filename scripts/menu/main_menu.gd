extends CanvasLayer
@export var game_scene : Resource
@export var credits_scene : Resource
@export var changelog_scene : Resource

@export var MENU_MUSIC : Resource
@export var PIZZA_MUSIC : Resource

func _ready() -> void:
	# Connect the finished signal if not already connected
	if not MusicPlayer.is_connected("finished", Callable(self, "_on_music_finished")):
		MusicPlayer.connect("finished", Callable(self, "_on_music_finished"))
	# If the music player is not playing or if the music playing is not the menu music or pizza music, play the menu music
	if not MusicPlayer.stream or (MusicPlayer.stream.resource_path != MENU_MUSIC.resource_path and MusicPlayer.stream.resource_path != PIZZA_MUSIC.resource_path):
		MusicPlayer.stream = MENU_MUSIC
		MusicPlayer.play()


func _on_start_pressed() -> void:
	MenuPageChangeSound.play();
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
	MusicPlayer.stream = PIZZA_MUSIC
	MusicPlayer.play()
	pass # Replace with function body.


func _on_close_game_button_pressed() -> void:
	get_tree().quit()

func _on_music_finished() -> void:
	# restart menu music
	MusicPlayer.stream = MENU_MUSIC
	MusicPlayer.play()
