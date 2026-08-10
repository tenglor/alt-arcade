extends Node2D

var quarter := 0

var input_enable = true

signal quarter_clicked(quarter_number)

@onready var input_mask = 0xF

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)

func _input(event):
	if !input_enable:
		return
	# Обрабатываем только события нажатия левой кнопки мыши
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
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


func touched() -> bool:
	return true;
