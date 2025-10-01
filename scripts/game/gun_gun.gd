extends Marker2D

@export var bullet_scene : Resource

var shoots = false;
var damage = 0;
var spd_m = 1;
var cc = 1;

func get_distance(node: Node):
	return global_position.distance_to(node.global_position)

func _physics_process(delta):
	var enems = $Area2D.get_overlapping_bodies();
	shoots = enems.size() > 0;
	if enems.size() > 0:
		var dists = enems.map(get_distance)
		look_at(enems[dists.find(dists.min())].global_position);
	
func shoot():
	if(!shoots):
		return;
	real_shoot(rotation);
	var n = cc
	while(n > 0):
		if randf() < n:
			real_shoot(randf()*360)
		n -= 1;
	
	
func real_shoot(rot):
	Stats.bullets_shot += 1
	var b = bullet_scene # preload(bullet_scene);
	var new_b = b.instantiate();
	%ShootyShootyBangBang.add_child(new_b);
	new_b.global_position = %ShootyShootyBangBang.global_position;
	new_b.rotation = rot;
	new_b.damage = damage;
	new_b.spd = spd_m;
	
	
func _on_timer_timeout() -> void:
	shoot();
	
func set_timer_duration(time):
		%Timer.wait_time = time
		
func set_damage(v):
		damage = v;
func set_spd(v):
		spd_m = v;
func set_cc(v):
		cc = v;
	
