extends CharacterBody2D

@onready var player = get_node("/root/Game/PlayerLol")
@export var bullet_scene: Resource

var health = 15;
var MIN_DISTANCE = 400
var personal_rng = randf() * 500 - 250
var was_rotating = false

func create_bullet():
	var new_b = bullet_scene.instantiate()
	%Ranged.add_child(new_b)
	new_b.global_position = %Ranged.global_position
	new_b.rotation = (player.global_position - global_position).angle()

func _physics_process(delta):
	var time = Time.get_ticks_msec()
	
	if (player != null):
		var dir = global_position.direction_to(player.global_position)
		var dist = global_position.distance_to(player.global_position)
		
		var effective_min_distance = MIN_DISTANCE + personal_rng
		
		if abs(dist - effective_min_distance) < 10 + int(was_rotating) * 10:
			velocity = dir * dist;
			velocity = velocity.rotated(PI/2)
			was_rotating = true
			
		else:
			var mult = 1
			
			if dist < effective_min_distance:
				mult = -1
				
			velocity = dir * 400 * mult;
			
			was_rotating = false
		
		move_and_slide();
	
#func _ready() -> void:
#	%Ranged.play_walk(); # Does not exist yet.
	
func take_damage(amount):
	health -= amount;
	# %Ranged.play_hurt(); # Does not exist yet.
	if (health <= 0):
		queue_free(); 
		var c = preload("res://smoke_explosion/smoke_explosion.tscn");
		var s = c.instantiate();
		get_parent().add_child(s);
		s.global_position = global_position;


func _on_timer_timeout() -> void:
	if was_rotating:
		create_bullet()
