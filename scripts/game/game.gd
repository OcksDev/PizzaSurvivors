extends Node2D
	
@export var player : Node2D;
@export var nerd_scene : Resource

const STARTING_MUSIC = "res://audio/Food.mp3"
var enemies_for_wave = -1;
var current_wave = -1;

func _ready() -> void:
	# If the music player is not playing or if the music playing is not the starting music, play the starting game music
	if not MusicPlayer.stream or MusicPlayer.stream.resource_path != STARTING_MUSIC:
		MusicPlayer.stream = preload(STARTING_MUSIC)
		MusicPlayer.panning_strength = 0;
		MusicPlayer.max_distance = 100000000;
		MusicPlayer.play()
	startwave(0)


func spawn_mob():
	var mob = nerd_scene.instantiate();
	%PlayerLol._path().progress_ratio = randf();
	add_child(mob);
	mob.global_position = %PlayerLol._path().global_position;

func startwave(wave):
	current_wave = wave;
	enemies_for_wave = 5 + (3*wave);
	%SubTimer.wait_time = (0.9 / ((0.15 * wave) + 1)) + 0.1;
	%SubTimer.start();


func _on_timer_timeout() -> void:
	spawn_mob();
	enemies_for_wave -= 1;
	if (enemies_for_wave > 0):
		%SubTimer.start();
	else:
		%WaveTimer.start();


func _on_player_lol_died_lol() -> void:
	%DeadMenu.visible = true;
	get_tree().paused = true;


func _on_wave_timer_timeout() -> void:
	startwave(current_wave + 1);
