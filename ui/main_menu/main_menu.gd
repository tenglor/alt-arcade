extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.ambient_sound_start()
	$VersionLabel.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	pass # Replace with function body.


func _on_new_game_button_pressed() -> void:
	AudioManager.ambient_sound_stop()
	Global.load_scene(Global.test_scene)
	# var target_scene = "res://scenes/test.tscn"
	# var old_room = get_tree().current_scene

	# var new_room = load(target_scene).instantiate()
	# get_tree().root.add_child(new_room)
	# get_tree().current_scene = new_room
	# old_room.queue_free()


func _on_exit_button_pressed() -> void:
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
