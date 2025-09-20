extends RigidBody2D

const PUSHED_SPEED = 50

func _on_area_2d_body_entered(body: Node2D) -> void:
	var direction = (global_position - body.global_position).normalized()
	apply_central_impulse(direction * PUSHED_SPEED)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	var direction = (global_position - area.global_position).normalized()
	apply_central_impulse(direction * PUSHED_SPEED)
