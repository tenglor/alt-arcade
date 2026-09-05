extends Node

const CATCH_SOUND = preload("res://sounds/catch2.wav")
const CRASH_SOUND = preload("res://sounds/keys.wav")
const AMBIENT_SOUND = "res://sounds/ambient_mansion2.wav"
var ambient_sound


func catch_sound() -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = CATCH_SOUND
	sound.volume_db = -3
	add_child(sound)
	# sound.play(3.95)
	sound.play(21.72)
	await get_tree().create_timer(0.4).timeout
	sound.stop()
	sound.queue_free()

func crash_sound() -> void:
	var sound = AudioStreamPlayer.new()
	sound.stream = CRASH_SOUND
	sound.volume_db = -9
	add_child(sound)
	sound.play(2.69)
	await get_tree().create_timer(0.6).timeout
	sound.stop()
	sound.queue_free()

func ambient_sound_start() -> void:
	var wav_resource = load(AMBIENT_SOUND) as AudioStreamWAV
	ambient_sound = AudioStreamPlayer.new()
	ambient_sound.stream = wav_resource
	# sound.volume_db = -15
	add_child(ambient_sound)
	var seconds = 378
	var sample_rate = wav_resource.mix_rate  # обычно 44100 или 48000
	var loop_end_samples = int(seconds * sample_rate)
	wav_resource.loop_mode = AudioStreamWAV.LOOP_FORWARD
	wav_resource.loop_end = loop_end_samples
	ambient_sound.play()

func ambient_sound_stop():
	ambient_sound.stop()
