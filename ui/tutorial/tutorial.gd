# extends CanvasLayer
extends Node2D

var tutorial_steps = []
var current_step = 0

@onready var player_preload = preload("res://actors/player/player.tscn")
@onready var roost_preload = preload("res://objects/roost/roost.tscn")

@onready var click_area_show = $ClickAreaShow

func _ready() -> void:
	var game_name = ProjectSettings.get_setting("application/config/name")
	tutorial_steps = [
		{"text": "Добро пожаловать в игру \"{game_name}\"".format({"game_name": game_name})},
		{"text": "Это Мария. Её задача - прислуживать гарему коледи \nодного высокопоставленного рустермена (roosterman)"},
		{"text": "Не беспокойтесь. Ей хорошо платят, а коледи и владелец гарема относятся к ней уважительно"},
		{"text": "Однажды я расскажу об этом историю"},
		{"text": "Это ваше рабочее место. Коледи здесь иногда отдыхают"},
		{"text": "Одна из коледи снесла яйцо. Нужно его поймать"},
		{"text": "Экран поделен на четыре части. \nЧтобы сказать Марии поймать верхнее левое яйцо, \nнадо нажать на левую верхнюю часть экрана. \nПопробуйте"},
		{"text": "Тирлим бом-бом"}
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

	var dialog
	dialog = show_message(tutorial_steps[0])
	await dialog.confirmed

	var player = player_preload.instantiate()
	add_child(player)
	player.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y)

	dialog = show_message(tutorial_steps[1])
	await dialog.confirmed

	dialog = show_message(tutorial_steps[2])
	await dialog.confirmed

	dialog = show_message(tutorial_steps[3])
	await dialog.confirmed

	var roost = roost_preload.instantiate()
	add_child(roost)

	dialog = show_message(tutorial_steps[4])
	await dialog.confirmed

	var egg = roost.get_node("Perch0").spawn_egg()
	add_child(egg)

	dialog = show_message(tutorial_steps[5])
	await dialog.confirmed

	click_area_show.visible = true

	dialog = show_message(tutorial_steps[6])
	await dialog.confirmed

	while true:
		var pressed_index: int = await player.quarter_clicked
		if pressed_index == 0:
			break

	dialog = show_message(tutorial_steps[6])
	await dialog.confirmed



func show_message(item):
	var dialog = AcceptDialog.new()
	dialog.title = "Обучение"
	dialog.dialog_text = item.text
	dialog.ok_button_text = "Да"
	add_child(dialog)
	dialog.popup_centered()
	return dialog
