class_name AudioManager extends Node

func _ready() -> void:
	Global.audio_manager = self

func play_sound(sound: AudioStream, loop: bool = false, volume: int = -10) -> AudioStreamPlayer:
	var audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = sound
	audio_stream_player.volume_db = volume
	if loop:
		audio_stream_player.loop = true
	else:
		audio_stream_player.finished.connect(func():
			audio_stream_player.queue_free()
		)
	add_child(audio_stream_player)
	audio_stream_player.play()
	return audio_stream_player
