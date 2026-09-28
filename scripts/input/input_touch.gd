extends Node2D

var quarter := 0

var input_enable = true

signal quarter_clicked(quarter_number)

@onready var input_mask = 0xF

var input_delay = 0.1
var current_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)

func _input(event):
	if !input_enable:
		return
	if current_time < input_delay:
		return
	# Обрабатываем только события нажатия левой кнопки мыши
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !event.is_echo():
		var click_pos = event.position           # Координаты клика (в пикселях)
		var screen_size = get_viewport().get_visible_rect().size  # Размеры окна/экрана

		var half_width = screen_size.x / 2.0
		var half_height = screen_size.y / 2.0

		var quarter_bit = 0x1
		if click_pos.x < half_width and click_pos.y < half_height:
			quarter = 0   # Верхняя левая четверть
		elif click_pos.x >= half_width and click_pos.y < half_height:
			quarter = 1   # Верхняя правая четверть
			quarter_bit = quarter_bit << 1
		elif click_pos.x < half_width and click_pos.y >= half_height:
			quarter = 2   # Нижняя левая четверть
			quarter_bit = quarter_bit << 2
		else:
			quarter = 3   # Нижняя правая четверть
			quarter_bit = quarter_bit << 3

		if input_mask & quarter_bit:
			quarter_clicked.emit(quarter)
	elif event is InputEventKey and event.pressed and !event.is_echo():
		var quarter_bit = 0x1
		var quarter_changed = false
		if event.keycode == KEY_Q:
			quarter_changed = true
			quarter = 0
		elif event.keycode == KEY_E:
			quarter_changed = true
			quarter = 1
			quarter_bit = quarter_bit << 1
		elif event.keycode == KEY_A:
			quarter_changed = true
			quarter = 2
			quarter_bit = quarter_bit << 2
		elif event.keycode == KEY_D:
			quarter_changed = true
			quarter = 3
			quarter_bit = quarter_bit << 3

		if quarter_changed and input_mask & quarter_bit:
			quarter_clicked.emit(quarter)
	current_time = 0

func _process(delta: float) -> void:
	current_time += delta

func touched() -> bool:
	return true;
