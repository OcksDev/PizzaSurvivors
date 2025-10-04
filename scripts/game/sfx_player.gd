extends Node2D

func play_and_delete_sound(
	sound_path: String, 
	min_pitch_scale: float = 1.0, 
	max_pitch_scale: float = 1.0, 
	from_position: float = 0.0, 
	world_position: Vector2 = Vector2.ZERO
) -> void:
	
	var audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)

	# Load and assign sound
	var sound = load(sound_path)
	audio_player.stream = sound

	# Set position in world (important for panning)
	audio_player.global_position = world_position
	
	# Set audio bus to be game sfx
	audio_player.bus = "GameSFX"

	# Set random pitch
	audio_player.pitch_scale = randf_range(min_pitch_scale, max_pitch_scale)

	# Auto-delete after playing
	audio_player.connect("finished", Callable(audio_player, "queue_free"))

	# Play sound
	audio_player.play(from_position)
