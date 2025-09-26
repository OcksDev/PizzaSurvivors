extends Node2D
	
@export var player : Node2D;

@export var melee_enemy : Resource
@export var ranged_enemy : Resource
@export var boss_enemy : Resource

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
const KETCHUP = preload("res://scenes/game/ketchup.tscn")
const KETCHUP_MIN_SIZE = 1
const KETCHUP_MAX_SIZE = 5
const KETCHUP_SPAWN_RATE = 1 # Integer value; 2 will spawn 2 ketchup at wave 1, 4 at wave 2, etc
const MAX_KETCHUP_SPAWN_PER_WAVE = 8

var enemies_for_wave = -1
var current_wave = -1
var max_wave_enemies = -1


### Map generation:

func spawn_bottlecap():
	var bottlecap_instance = BOTTLECAP.instantiate()
	add_child(bottlecap_instance)
	bottlecap_instance.position = Vector2(randi_range(MIN_X, MAX_X), randi_range(MIN_Y, MAX_Y))
	
func spawn_ketchup():
	var ketchup_instance = KETCHUP.instantiate()
	add_child(ketchup_instance)
	# Randomize the size
	var ketchup_scale = randi_range(KETCHUP_MIN_SIZE, KETCHUP_MAX_SIZE)
	ketchup_instance.scale = Vector2(ketchup_scale, ketchup_scale)
	# Spawn it just outside of view
	%PlayerLol._path().progress_ratio = randf();
	ketchup_instance.global_position = %PlayerLol._path().global_position;
	# Connect is to player so player can get signals from it
	ketchup_instance.connect("ketchup_entered", Callable(player, "_on_ketchup_entered"))
	ketchup_instance.connect("ketchup_exited", Callable(player, "_on_ketchup_exited"))
	
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

### Ready:

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
	
	%ItemMenu.visible = false;
	startwave(0)

### Enemy spawning:

func spawn_mob():
	var mob
	
	var current_enemy = (enemies_for_wave / (current_wave * 3 + 1.0))
	var previous_enemy = ((enemies_for_wave + 1) / (current_wave * 3 + 1.0))
	var boss_threshold = 1 / ((current_wave + 1) / 5.0 + 1.0)
	
	if ((current_wave + 1)  % 5 == 0) \
	  and (int(previous_enemy / boss_threshold) > int(current_enemy / boss_threshold)) \
	  and (max_wave_enemies - enemies_for_wave != 1):
		# Wave 5 is 1 boss enemy (at enemies/max = 0.5)
		# Wave 10 is 2 boss enemies (at enemies/max = 0.33 or 0.66)
		mob = boss_enemy.instantiate();
	elif randf() < min(current_wave / 10.0, 0.5):
		mob = ranged_enemy.instantiate();
	else:
		mob = melee_enemy.instantiate();
		
	%PlayerLol._path().progress_ratio = randf();
	add_child(mob);
	mob.global_position = %PlayerLol._path().global_position;

func startwave(wave):
	current_wave = wave;
	max_wave_enemies = 1 + (3 * wave)
	enemies_for_wave = max_wave_enemies
	%SubTimer.wait_time = (0.9 / ((0.15 * wave) + 1)) + 0.1;
	%SubTimer.start();
	%CurrentWaveDisplay.text = "Current Wave: " + str(current_wave+1);
	
	# Spawn more ketchup (blood) the further into the game you go
	for i in range(min(wave * KETCHUP_SPAWN_RATE, MAX_KETCHUP_SPAWN_PER_WAVE)):
		spawn_ketchup()

### Upgrade management:

func show_items():
	%ItemMenu.visible = true
	%ItemMenu.set_random_items(player.item_titles, player.item_descs, self)
	
func select_item(item):
	%ItemMenu.visible = false;
	player.items[item] += 1;
	player.update_player_stats()
	startwave(current_wave + 1);

### Misc. events:

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
	show_items();
