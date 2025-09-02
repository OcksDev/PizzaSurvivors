extends Marker2D


var shoots = false;

func _physics_process(delta):
	var enems = $Area2D.get_overlapping_bodies();
	shoots = enems.size() > 0;
	if enems.size() > 0:
		look_at(enems[0].global_position);
	
func shoot():
	if(!shoots):
		return;
	var b = preload("res://bullet.tscn");
	var new_b = b.instantiate();
	%ShootyShootyBangBang.add_child(new_b);
	new_b.global_position = %ShootyShootyBangBang.global_position;
	new_b.rotation = rotation;
	
func _on_timer_timeout() -> void:
	shoot();
	
