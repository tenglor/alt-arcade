# extends CanvasLayer
extends Node2D

var tutorial_steps = []
var current_step = 0

@onready var click_area_show = $ClickAreaShow

func _ready() -> void:
	var game_name = ProjectSettings.get_setting("application/config/name")
	tutorial_steps = [
		{"text": "Добро пожаловать в игру \"{game_name}\"".format({"game_name": game_name})}
	]

	var horizontal_line = Line2D.new()
	horizontal_line.width = 2
	horizontal_line.default_color = Color(1,1,1,0.3)
	horizontal_line.add_point(Vector2(0, get_viewport().size.y / 2))
	horizontal_line.add_point(Vector2(get_viewport().size.x, get_viewport().size.y / 2))
	click_area_show.add_child(horizontal_line)

	var vertical_line = Line2D.new()
	vertical_line.width = 2
	vertical_line.default_color = Color(1,1,1,0.3)
	vertical_line.add_point(Vector2(get_viewport().size.x / 2, 0))
	vertical_line.add_point(Vector2(get_viewport().size.x / 2, get_viewport().size.y))
	click_area_show.add_child(vertical_line)

	var dialog = AcceptDialog.new()
	dialog.title = "Обучение"
	dialog.dialog_text = tutorial_steps[0].text
	dialog.ok_button_text = "Да"
	add_child(dialog)
	dialog.popup_centered()
