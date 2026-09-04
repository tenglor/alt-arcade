extends Node

const CATCH_SOUND = preload("res://sounds/grab.wav")
const CRASH_SOUND = preload("res://sounds/keys.wav")

func catch_sound() -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = CATCH_SOUND
	sound.volume_db = -12
	add_child(sound)
	sound.play(3.37)
	await get_tree().create_timer(0.4).timeout
	sound.stop()
	sound.queue_free()



func crash_sound() -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = CRASH_SOUND
	sound.volume_db = -12
	add_child(sound)
	sound.play(2.69)
	await get_tree().create_timer(0.6).timeout
	sound.stop()
	sound.queue_free()
