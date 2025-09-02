extends Node2D
	
func spawn_mob():
	var mob = preload("res://nerd.tscn").instantiate();
	%PlayerLol._path().progress_ratio = randf();
	add_child(mob);
	mob.global_position = %PlayerLol._path().global_position;
	


func _on_timer_timeout() -> void:
	spawn_mob();


func _on_player_lol_died_lol() -> void:
	%DeadMenu.visible = true;
	get_tree().paused = true;
