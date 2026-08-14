# extends CanvasLayer
extends Node2D

var tutorial_steps = []
var current_step = 0

@onready var player_preload = preload("res://actors/player/player.tscn")
@onready var roost_preload = preload("res://objects/roost/roost.tscn")

@onready var click_area_show = $ClickAreaShow
@onready var tada = $Tada

var roost

var click_zone

signal any_event_called

func _ready() -> void:
	var game_name = ProjectSettings.get_setting("application/config/name")
	tutorial_steps = [
		{"text": "Добро пожаловать в игру \"{game_name}\"".format({"game_name": game_name})},
		{"text": "Это Мария.\nНекий пемуж нанял её,\nчтобы она прислуживала его кудевам"},
		{"text": "Однажды я расскажу об этом историю"},
		{"text": "Это ваше рабочее место. Коледи здесь иногда отдыхают."},
		{"text": "Одна из коледи снесла яйцо. Нужно его поймать."},
		{"text": "Экран поделен на четыре части. \nЧтобы сказать Марии подойти к верхнему левому насеста, \nнадо нажать на соответствующую часть экрана. \nПопробуйте"},
		{"text": "Как вы видите, Мария переместилась.\nПодождем, когда яйцо скатится"},
		{"text": "Вы поймали яйцо!"},
		{"text": "Появилось еще одно яйцо. Поймайте его по аналогии с предыдущим"},
		{"text": "Появилось новое яйцо, хотя вы еще не поймали текущее.\nНе беспокойтесь.\nСначала дождитесь когда Мария поймает текущее яйцо,\nпосле чего
			быстро передвиньте Марию к другому насесту, чтобы она успела поймать второе яйцо"},
		{"text": "Яйцо разбилось!\nПопробуйте еще раз"},
		{"text": "Поздравляю! Вы справились с обучением! Возвращаю вас обратно"}
	]
	var step_i = 0

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
	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	await get_tree().create_timer(0.5).timeout
	var player = get_node("Player")
	player.visible = true
	var input = player.get_node("Controller")
	input.input_enable = false
	# player.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y)
	tada.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y * 3 / 4)
	tada.restart()
	await get_tree().create_timer(1.5).timeout

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	dialog = show_message(tutorial_steps[step_i])
	step_i+=1
	await dialog.confirmed

	await get_tree().create_timer(0.5).timeout
	roost = roost_preload.instantiate()
	add_child(roost)
	await get_tree().create_timer(1.5).timeout

	dialog = show_message(tutorial_steps[step_i])
	step_i+=1
	await dialog.confirmed

	var egg = roost.get_node("Perch0").spawn_egg()
	add_child(egg)
	egg.process_mode = Node.PROCESS_MODE_DISABLED

	dialog = show_message(tutorial_steps[step_i])
	step_i+=1
	await dialog.confirmed

	click_area_show.visible = true

	dialog = show_message(tutorial_steps[step_i])
	step_i+=1
	await dialog.confirmed

	input.input_enable = true
	click_zone = Line2D.new()
	click_zone.width = 4
	click_zone.default_color = Color.YELLOW
	click_zone.modulate = Color(1, 1, 0, 0.8)
	click_zone.add_point(Vector2(0, 0))
	click_zone.add_point(Vector2(get_viewport_rect().size.x / 2, 0))
	click_zone.add_point(Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2))
	click_zone.add_point(Vector2(0, get_viewport_rect().size.y / 2))
	click_area_show.add_child(click_zone)

	var tween: Tween = create_tween()
	tween.set_loops()
	tween.tween_property(click_zone, "modulate", Color.YELLOW, 0.5)
	tween.tween_property(click_zone, "modulate", Color.ORANGE, 0.5)
	tween.tween_property(click_zone, "modulate", Color.RED, 0.5)
	tween.tween_property(click_zone, "modulate", Color.YELLOW, 0.5)

	input.input_mask = 0x1
	while true:
		var pressed_index: int = await input.quarter_clicked
		if pressed_index == 0:
			break
	input.input_mask = 0xF

	click_area_show.visible = false
	input.input_enable = false

	await get_tree().create_timer(1).timeout

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed
	egg.process_mode = Node.PROCESS_MODE_INHERIT


	await egg.caught

	input.input_enable = true

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	egg = roost.get_node("Perch3").spawn_egg()
	add_child(egg)
	egg.process_mode = Node.PROCESS_MODE_DISABLED

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	egg.process_mode = Node.PROCESS_MODE_INHERIT

	await get_tree().create_timer(2).timeout

	var egg2 = roost.get_node("Perch2").spawn_egg()
	add_child(egg2)
	egg.process_mode = Node.PROCESS_MODE_DISABLED
	egg2.process_mode = Node.PROCESS_MODE_DISABLED

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	egg.process_mode = Node.PROCESS_MODE_INHERIT
	egg2.process_mode = Node.PROCESS_MODE_INHERIT

	var egg_status = {
		"egg1_caught": false,
		"egg2_caught": false,
		"egg1_crushed": false,
		"egg2_crushed": false,
	}

	egg.crashed.connect(egg_crashed.bind(egg_status, 1))
	egg2.crashed.connect(egg_crashed.bind(egg_status, 2))
	# egg.caught.connect(egg_caught.bind(egg_status, 1))
	egg2.caught.connect(egg_caught.bind(egg_status, 2))

	step_i = step_i + 1
	while true:
		await any_event_called

		if egg_status["egg2_caught"]:
			break
		if egg_status["egg1_crushed"]:
			egg2.queue_free()

		step_i = step_i - 1
		dialog = show_message(tutorial_steps[step_i])
		step_i = step_i + 1
		await dialog.confirmed

		egg = roost.get_node("Perch3").spawn_egg()
		add_child(egg)

		await get_tree().create_timer(2).timeout

		egg2 = roost.get_node("Perch2").spawn_egg()
		add_child(egg2)

		egg.crashed.connect(egg_crashed.bind(egg_status, 1))
		egg2.crashed.connect(egg_crashed.bind(egg_status, 2))
		# egg.caught.connect(egg_caught.bind(egg_status, 1))
		egg2.caught.connect(egg_caught.bind(egg_status, 2))
		# if dict["egg1_crushed"]:



	# 	if egg2_caught:
	# 		break

	dialog = show_message(tutorial_steps[step_i])
	step_i += 1
	await dialog.confirmed

	Global.load_scene(Global.test_scene)

func egg_crashed(dict, index) -> void:
	var key = "egg" + str(index) + "_crushed"
	print(key)
	dict[key] = true
	any_event_called.emit()

func egg_caught(dict, index) -> void:
	var key = "egg" + str(index) + "_caught"
	print(key)
	dict[key] = true
	any_event_called.emit()

func two_eggs() -> bool:
	var egg:Node2D = roost.get_node("Perch3")
	add_child(egg)

	await get_tree().create_timer(2).timeout

	var egg2 = roost.get_node("Perch2")
	egg.crashed.disconnect(two_eggs)
	egg.crashed.disconnect(egg.queue_free)
	egg2.crashed.connect(egg2.queue_free)
	egg2.crashed.connect(egg.queue_free)
	egg2.crashed.connect(two_eggs)
	add_child(egg2)

	# var egg_caught = false

	# var egg2_caught = false

	# func

	await egg2.caught

	print("Пройдено!")
	return true

func set_border_alpha(value: float):
	for line in click_zone.get_children():
		line.modulate.a = value


func show_message(item):
	var dialog = AcceptDialog.new()
	dialog.title = "Обучение"
	dialog.dialog_text = item.text
	dialog.ok_button_text = "Да"
	dialog.get_label().horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(dialog)
	dialog.popup_centered()
	return dialog
