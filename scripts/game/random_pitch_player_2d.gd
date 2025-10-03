extends AudioStreamPlayer2D

@export var min_pitch_scale = 0.8
@export var max_pitch_scale = 1.2

func play_random_pitch(from_position: float = 0.0):
	pitch_scale = randf_range(min_pitch_scale, max_pitch_scale)
	play(from_position)
	
