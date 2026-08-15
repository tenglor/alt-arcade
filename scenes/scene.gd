extends Node

@onready var menu: Control = $UI/GameMenu
@onready var score: Control = $UI/EndGameDialog
var is_menu_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DifficultyManager.init()

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
