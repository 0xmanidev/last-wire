extends Node

var music_player: AudioStreamPlayer

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

	music_player.stream = preload("res://assets/09 Bioengineering -Long Version-.mp3")
	music_player.volume_db = -8.0
	music_player.bus = "Music"

	# Enable looping if supported by the audio file
	if music_player.stream is AudioStreamOggVorbis:
		music_player.stream.loop = true

	music_player.play()
