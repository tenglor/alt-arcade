extends Control

signal closed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PauseManager.add_ignore_pause(self)
	process_mode = PROCESS_MODE_ALWAYS
	# pass # Replace with function body.

func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("ui_cancel") and visible:		
		await get_tree().process_frame
		_on_continue_button_pressed()

func _on_return_title_button_pressed() -> void:
	PauseManager.resume_game()
	Global.load_scene("res://ui/main_menu/main_menu.tscn")

func _on_continue_button_pressed()->void:
	visible = false
	closed.emit()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
