extends Node

@onready var menu: Control = $GameMenu
@onready var score: Control = $EndGameDialog
var is_menu_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DifficultyManager.init()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_menu_open:
			close_menu()
		else:
			open_menu()

func open_score_dialog() -> void:
	score.visible = true
	get_tree().paused = true  # Пауза игры
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Показать курсор

func open_menu() -> void:
	menu.visible = true
	is_menu_open = true
	get_tree().paused = true  # Пауза игры
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Показать курсор

func close_menu() -> void:
	menu.visible = false
	is_menu_open = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Скрыть курсор

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
