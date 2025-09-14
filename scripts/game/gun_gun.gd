extends Marker2D

@export var bullet_scene : Resource

var shoots = false;

func _physics_process(delta):
	var enems = $Area2D.get_overlapping_bodies();
	shoots = enems.size() > 0;
	if enems.size() > 0:
		look_at(enems[0].global_position);
	
func shoot():
	if(!shoots):
		return;
	var b = bullet_scene # preload(bullet_scene);
	var new_b = b.instantiate();
	%ShootyShootyBangBang.add_child(new_b);
	new_b.global_position = %ShootyShootyBangBang.global_position;
	new_b.rotation = rotation;
	
func _on_timer_timeout() -> void:
	shoot();
	
