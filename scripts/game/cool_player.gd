extends CharacterBody2D

signal died_lol

@export var items = {
	"test_item":0,
	"test_item2":0,
	};

var health = 5.0;

func _physics_process(delta):
	var dir = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = dir * 600
	move_and_slide()
	var a = $HappyBoo
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
	%ProgressBar.value = health;
			
			
func _path():
	return %PathFollow2D;
