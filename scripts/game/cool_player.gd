extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D

@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound

signal died_lol

var items = {
	"damage_increase":0,
	"attack_speed_increase":0,
	"move_speed_increase":0,
	"max_health_increase":0,
	"bullet_amount_increase":0,
	"bullet_speed_increase":0,
	#"range_increase":0,
};
var item_titles = {
	"damage_increase":"Thicker Sauce",
	"attack_speed_increase":"Faster Serving",
	"move_speed_increase":"Swifter Feet",
	"max_health_increase":"Bigger Crust",
	"bullet_amount_increase":"Extra Cheese",
	"bullet_speed_increase":"Greasier Oil",
};
var item_descs = {
	"damage_increase":"+15% Damage",
	"attack_speed_increase":"+10% Attack Speed",
	"move_speed_increase":"+10% Movement Speed",
	"max_health_increase":"+25% Max Health",
	"bullet_amount_increase":"+25% chance to shoot an Extra Bullet in a Random Direction",
	"bullet_speed_increase":"+20% Bullet Speed",
};
var item_imgs = {
	# 0 = damage
	# 1 = utility
	# 2 = healing
	"damage_increase":0,
	"attack_speed_increase":0,
	"move_speed_increase":1,
	"max_health_increase":1,
	"bullet_amount_increase":0,
	"bullet_speed_increase":1,
	#"range_increase":0,
};
	
# changing these values does nothing, go to update_player_stats()
var health = -69.0; 
var damage = -69.0; 
var max_health = -69.0; 
var old_max_health = -69.0; 
var speed = -69.0; 
var new_bullet_chance = -69.0; 
var bullet_speed = -69.0; 

# player interaction with ketchup
var ketchups_in = 0; # number of ketchup objects the player is currently stepping on
var ketchup_slowdown = 0.6; # multiplier for velocity when player is walking through ketchup



func _ready():
	update_player_stats()

func _physics_process(delta):
	var velocity_mod = 1.0
	if ketchups_in >= 1:
		velocity_mod = ketchup_slowdown
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = dir * 600 * speed * velocity_mod
	
	if (dir.x > 0):
		%PlayerVisual.scale.x = 1;
	elif (dir.x < 0):
		%PlayerVisual.scale.x = -1;
	
	move_and_slide()
	if velocity.length() > 0:
		%AnimatedSprite2D.play("run")
		%AnimatedSprite2D.speed_scale = 2.5 * speed;
	else:
		%AnimatedSprite2D.play("idle")
		%AnimatedSprite2D.speed_scale = 1;
	var dr = 3;
	
	var overlaps = %ScareBox.get_overlapping_bodies();
	if(overlaps.size() > 0):
		take_damage(dr * overlaps.size() * delta)
	refresh_health_bar()

func refresh_health_bar():
	%ProgressBar.max_value = max_health
	%ProgressBar.value = health

func take_damage(amount):
	if not hurt_sound.is_playing():
		hurt_sound.play_random_pitch()
	health -= 0.1 # Overrides the amount of damage.
	if(health <= 0):
		died_lol.emit()
	refresh_health_bar()
	
	
var has_already = false
func update_player_stats():
	# base stats
	max_health = 5;
	var attack_time = 0.2 #seconds
	damage = 5
	speed = 1;
	bullet_speed = 1;
	new_bullet_chance = 0;
	
	# debug item giving
	#items["bullet_amount_increase"] = 10
	
	
	
	max_health *= 1 + (0.25 * items["max_health_increase"])
	
	if(has_already): # changes current health to remain proportional to changes in max_health
		var perc = max_health / old_max_health
		old_max_health = max_health;
		health *= perc; 
	else:
		health = max_health;
		old_max_health = max_health;
	
	attack_time /= 1 + (0.1 * items["attack_speed_increase"])
	%GunGun.set_timer_duration(attack_time)
	
	damage *= 1 + (0.15 * items["damage_increase"])
	%GunGun.set_damage(damage)
	
	
	speed *= 1 + (0.1 * items["move_speed_increase"])
	
	new_bullet_chance = (0.25 * items["bullet_amount_increase"])
	%GunGun.set_cc(new_bullet_chance)
	
	bullet_speed *= 1 + (0.2 * items["bullet_speed_increase"])
	%GunGun.set_spd(bullet_speed)
	
	has_already = true
	
	camera_2d.position_smoothing_speed = speed * 8.3333
	

func _path():
	return %PathFollow2D;



### Stepping in and out of ketchup
func _on_ketchup_entered():
	ketchups_in += 1
	
func _on_ketchup_exited():
	ketchups_in -= 1
