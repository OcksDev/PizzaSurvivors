extends Node2D
	
@export var player : Node2D;
@export var nerd_scene : Resource

const STARTING_MUSIC = "res://audio/Food.mp3"

func _ready() -> void:
	# If the music player is not playing or if the music playing is not the starting music, play the starting game music
	if not MusicPlayer.stream or MusicPlayer.stream.resource_path != STARTING_MUSIC:
		MusicPlayer.stream = preload(STARTING_MUSIC)
		MusicPlayer.play()


func spawn_mob():
	var mob = nerd_scene.instantiate();
	%PlayerLol._path().progress_ratio = randf();
	add_child(mob);
	mob.global_position = %PlayerLol._path().global_position;
	


func _on_timer_timeout() -> void:
	spawn_mob();


func _on_player_lol_died_lol() -> void:
	%DeadMenu.visible = true;
	get_tree().paused = true;
