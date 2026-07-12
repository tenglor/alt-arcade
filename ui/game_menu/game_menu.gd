extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	# pass # Replace with function body.

func _on_return_title_button_pressed() -> void:
	get_tree().paused = false
	Global.load_scene("res://ui/main_menu/main_menu.tscn")

func _on_continue_button_pressed()->void:
	get_tree().paused = false
	visible = false

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
