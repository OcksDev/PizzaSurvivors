extends Node2D

@onready var splash_sound: AudioStreamPlayer2D = $SplashSound
@export var menu_scene : Resource

func _ready() -> void:
	splash_sound.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: ", anim_name)
	get_tree().change_scene_to_packed(menu_scene)
