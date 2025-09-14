extends CharacterBody2D
@onready var player = get_node("/root/Game/PlayerLol")
var health = 3;
func _physics_process(delta):
	if(player != null):
		var dir = global_position.direction_to(player.global_position);
		velocity = dir * 400;
		move_and_slide();
	
func _ready() -> void:
	%Slime.play_walk();
	
func take_damage():
	health -= 1;
	%Slime.play_hurt();
	if (health <= 0):
		queue_free(); 
		var c = preload("res://smoke_explosion/smoke_explosion.tscn");
		var s = c.instantiate();
		get_parent().add_child(s);
		s.global_position = global_position;
	
