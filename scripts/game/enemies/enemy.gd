extends CharacterBody2D

@onready var player = get_node("/root/Game/PlayerLol")
var health = 15;
var game;

func _physics_process(delta):
	if(player != null):
		var dir = global_position.direction_to(player.global_position);
		velocity = dir * 400;
		move_and_slide();
	
func _ready() -> void:
	%AnimatedSprite2D.play("walk")
	
func take_damage(amount):
	health -= amount;
	%AnimatedSprite2D.play("attack")
	if (health <= 0):
		SfxPlayer.play_and_delete_sound("res://audio/hunger-death.wav", 0.7, 1.1, 0.0, global_position)
		game.killed_enems += 1;
		Stats.enemies_killed += 1
		queue_free(); 
		var c = preload("res://smoke_explosion/smoke_explosion.tscn");
		var s = c.instantiate();
		get_parent().add_child(s);
		s.global_position = global_position;
