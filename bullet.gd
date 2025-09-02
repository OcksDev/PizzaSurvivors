extends Area2D
var total_dist = 0;
func _physics_process(delta: float):
	const speed = 2000;
	const max_dist = 2000;
	
	var dir = Vector2.RIGHT.rotated(rotation);
	position +=  dir * speed * delta;
	total_dist += speed * delta;
	if total_dist >= max_dist:
		queue_free(); # what


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"): body.take_damage(); 
	queue_free();
