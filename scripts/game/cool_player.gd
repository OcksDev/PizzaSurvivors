extends CharacterBody2D

signal died_lol

@export var items = {
	"damage_increase":0,
	"attack_speed_increase":0,
	"move_speed_increase":0,
	#"bullet_amount_increase":0,
	"max_health_increase":0,
	};
	
	
# changing these values does nothing, go to update_player_stats()
var health = -69.0; 
var damage = -69.0; 
var max_health = -69.0; 
var old_max_health = -69.0; 
var speed = -69.0; 


func _ready():
	update_player_stats()

func _physics_process(delta):
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = dir * 600 * speed
	
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
		health -= dr * overlaps.size() * delta;
		if(health <= 0):
			#dqueue_free();
			died_lol.emit();
	%ProgressBar.max_value = max_health;
	%ProgressBar.value = health;
	
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
