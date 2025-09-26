extends CharacterBody2D

signal died_lol

var items = {
	"damage_increase":0,
	"attack_speed_increase":0,
	"move_speed_increase":0,
	#"bullet_amount_increase":0,
	"max_health_increase":0,
};
var item_titles = {
	"damage_increase":"Extra Sauce",
	"attack_speed_increase":"Faster Serving",
	"move_speed_increase":"Swifter Feet",
	#"bullet_amount_increase":"M Increase",
	"max_health_increase":"Stronger Cheese",
};
var item_descs = {
	"damage_increase":"+10% Damage",
	"attack_speed_increase":"+10% Attack Speed",
	"move_speed_increase":"+10% Movement Speed",
	#"bullet_amount_increase":"M Increase",
	"max_health_increase":"+25% Max Health",
};
	
	
# changing these values does nothing, go to update_player_stats()
var health = -69.0; 
var damage = -69.0; 
var max_health = -69.0; 
var old_max_health = -69.0; 
var speed = -69.0; 

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
	var a = %HappyBoo
	if velocity.length() > 0:
		a.play_walk_animation()
	else:
		a.play_idle_animation()
	var dr = 3;
	
	var overlaps = %ScareBox.get_overlapping_bodies();
	if(overlaps.size() > 0):
		take_damage(dr * overlaps.size() * delta)
	refresh_health_bar()

func refresh_health_bar():
	%ProgressBar.max_value = max_health
	%ProgressBar.value = health

func take_damage(amount):
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
	
	damage *= 1 + (0.1 * items["damage_increase"])
	%GunGun.set_damage(damage)
	
	speed *= 1 + (0.1 * items["move_speed_increase"])
	
	has_already = true
	

func _path():
	return %PathFollow2D;



### Stepping in and out of ketchup
func _on_ketchup_entered():
	ketchups_in += 1
	
func _on_ketchup_exited():
	ketchups_in -= 1
