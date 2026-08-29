extends Node

@onready var ui: Control = $MenuCanvasLayer/UI
var menu: Control
var score: Control
var tutorial_dialog
var is_menu_open: bool = false
signal _tutorial_offer_passed

func _hard_cancel_tutorial(action: StringName):
	PauseManager.resume_game()
	Global.tutorial_offer = false
	tutorial_dialog.visible = false
	_tutorial_offer_passed.emit()

func _jump_to_tutorial():
	PauseManager.resume_game()
	Global.load_scene(Global.tutorial_scene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu = ui.get_node("GameMenu")
	score = ui.get_node("EndGameDialog")
	tutorial_dialog = ui.get_node("ConfirmationDialog")

	if tutorial_dialog && Global.tutorial_offer:
		PauseManager.pause_game()
		PauseManager.add_ignore_pause(tutorial_dialog)
		tutorial_dialog.visible = true
		tutorial_dialog.title = "Обучение"
		tutorial_dialog.dialog_text = "Хотите пройти обучение?"
		tutorial_dialog.ok_button_text = "Да"
		tutorial_dialog.cancel_button_text = "Нет"
		tutorial_dialog.get_label().horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		tutorial_dialog.add_button("Отстань", true, "hard_cancel_tutorial")
		tutorial_dialog.popup_centered()
		tutorial_dialog.confirmed.connect(_jump_to_tutorial)
		tutorial_dialog.canceled.connect(_tutorial_offer_passed.emit)
		tutorial_dialog.custom_action.connect(_hard_cancel_tutorial)

		await _tutorial_offer_passed

		PauseManager.resume_game()

	DifficultyManager.reset()
	menu.closed.connect(close_menu)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_menu_open:
			 #close_menu()
			pass
		else:
			open_menu()

func open_score_dialog() -> void:
	score.visible = true
	PauseManager.pause_game()

func open_menu() -> void:
	menu.visible = true
	is_menu_open = true
	PauseManager.pause_game()

func close_menu() -> void:
	#menu.visible = false
	is_menu_open = false
	PauseManager.resume_game()
