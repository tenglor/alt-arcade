extends Node2D

var quarter := 0


signal quarter_clicked(quarter_number)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true) 

func _input(event):
	# Обрабатываем только события нажатия левой кнопки мыши
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var click_pos = event.position           # Координаты клика (в пикселях)
		var screen_size = get_viewport().get_visible_rect().size  # Размеры окна/экрана
		
		var half_width = screen_size.x / 2.0
		var half_height = screen_size.y / 2.0
		
		if click_pos.x < half_width and click_pos.y < half_height:
			quarter = 0   # Верхняя левая четверть
		elif click_pos.x >= half_width and click_pos.y < half_height:
			quarter = 1   # Верхняя правая четверть
		elif click_pos.x < half_width and click_pos.y >= half_height:
			quarter = 2   # Нижняя левая четверть
		else:
			quarter = 3   # Нижняя правая четверть
		
		quarter_clicked.emit(quarter)


func touched() -> bool:
	return true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
