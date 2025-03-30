class_name AudioManager extends Node

func _ready() -> void:
    Global.audio_manager = self

func play_sound(sound: AudioStream, loop: bool) -> AudioStreamPlayer:
    var audio_stream_player = AudioStreamPlayer.new()
    audio_stream_player.stream = sound
    audio_stream_player.volume_db = -10
    if loop:
        audio_stream_player.loop = true
    else:
        audio_stream_player.finished.connect("on_audio_finished", audio_stream_player)
    add_child(audio_stream_player)
    audio_stream_player.play()
    return audio_stream_player

func on_audio_finished(audio_stream_player: AudioStreamPlayer) -> void:
    audio_stream_player.queue_free()