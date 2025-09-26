extends Sprite2D

signal ketchup_entered
signal ketchup_exited

func _on_area_2d_area_entered(area: Area2D) -> void:
	emit_signal("ketchup_entered")


func _on_area_2d_area_exited(area: Area2D) -> void:
	emit_signal("ketchup_exited")
