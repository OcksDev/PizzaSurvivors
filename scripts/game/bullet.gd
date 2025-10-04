extends Area2D
var total_dist = 0
var damage = 0
var spd = 1

const speed = 2000
const max_dist = 2000


func _physics_process(delta: float):
	var dir = Vector2.RIGHT.rotated(rotation)
	position += dir * speed * delta * spd
	total_dist += speed * delta * spd
	
	if total_dist >= max_dist:
		queue_free() # what


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
