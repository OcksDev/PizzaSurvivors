extends CharacterBody2D

@onready var player = get_node("/root/Game/PlayerLol")
var health = 15 * 5 # 5 times the health of a regular enemy.
var game;
func _physics_process(delta):
	if(player != null):
		var dir = global_position.direction_to(player.global_position);
		velocity = dir * 100; # 4x slower movement than a regular enemy.
		move_and_slide();
		%AnimatedSprite2D.play("walk")
	
#func _ready() -> void:
	#%Slime.play_walk();
	
func take_damage(amount):
	health -= amount;
	#%Slime.play_hurt();
	if (health <= 0):
		SfxPlayer.play_and_delete_sound("res://audio/boss-death.wav", 0.35, 0.6, 0.0, global_position)
		game.killed_enems += 1;
		Stats.enemies_killed += 1
		queue_free(); 
		Global.player.heal_kill()
		var c = preload("res://smoke_explosion/smoke_explosion.tscn");
		var s = c.instantiate();
		get_parent().add_child(s);
		s.global_position = global_position;
