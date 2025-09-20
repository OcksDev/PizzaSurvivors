extends Node2D
	
@export var player : Node2D;
@export var nerd_scene : Resource

const STARTING_MUSIC = "res://audio/Food.mp3"

# Constants for spawning world objects
const MIN_X = -4900
const MAX_X = 4900
const MIN_Y = -4900
const MAX_Y = 4900
const BOTTLECAP = preload("res://scenes/game/bottlecap.tscn")
const NUM_BOTTLECAPS = 70
const SALT_UPRIGHT = preload("res://scenes/game/salt_shaker_upright.tscn")
const SALT_RIGHT = preload("res://scenes/game/salt_shaker_right.tscn")
const SALT_LEFT = preload("res://scenes/game/salt_shaker_left.tscn")
const SALT_UPRIGHT_RATIO = 3 # For every upright saltshaker, there will be 1 fallen to the left and 1 fallen to the right
const SALT_RIGHT_RATIO = 1
const SALT_LEFT_RATIO = 1
const NUM_SALTSHAKERS = 30 # An odd number could cause a saltshaker to spawn on the player at start

var enemies_for_wave = -1;
var current_wave = -1;

func spawn_bottlecap():
	var bottlecap_instance = BOTTLECAP.instantiate()
	add_child(bottlecap_instance)
	bottlecap_instance.position = Vector2(randi_range(MIN_X, MAX_X), randi_range(MIN_Y, MAX_Y))
	
func spawn_saltshaker(saltshaker_location):
	var saltshaker_instance
	var shaker_type_randomizer = randi_range(1, SALT_UPRIGHT_RATIO + SALT_RIGHT_RATIO + SALT_LEFT_RATIO)
	if shaker_type_randomizer <= SALT_UPRIGHT_RATIO:
		saltshaker_instance = SALT_UPRIGHT.instantiate()
	elif shaker_type_randomizer <= SALT_UPRIGHT_RATIO + SALT_RIGHT_RATIO:
		saltshaker_instance = SALT_RIGHT.instantiate()
	else:
		saltshaker_instance = SALT_LEFT.instantiate()
	saltshaker_instance.position = Vector2(saltshaker_location)
	add_child(saltshaker_instance)

func _ready() -> void:
	# If the music player is not playing or if the music playing is not the starting music, play the starting game music
	if not MusicPlayer.stream or MusicPlayer.stream.resource_path != STARTING_MUSIC:
		MusicPlayer.stream = preload(STARTING_MUSIC)
		MusicPlayer.play()
	
	# Create world objects
	for i in range(NUM_BOTTLECAPS):
		spawn_bottlecap()
	# Saltshakers should not overlap with each other, so evenly space out their x values
	var saltshaker_locations = []
	for i in range(NUM_SALTSHAKERS):
		saltshaker_locations.append(Vector2(MIN_X + (i * ((MAX_X - MIN_X) / NUM_SALTSHAKERS)), randi_range(MIN_Y, MAX_Y)))
	for saltshaker_location in saltshaker_locations:
		spawn_saltshaker(saltshaker_location)
		
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
	%CurrentWaveDisplay.text = "Current Wave: " + str(current_wave+1);


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
