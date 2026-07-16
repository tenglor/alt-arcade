extends CanvasLayer

func _ready() -> void:
	var horizontal_line = Line2D.new()
	horizontal_line.width = 2
	horizontal_line.default_color = Color(1,1,1,0.3)
	horizontal_line.add_point(Vector2(0, get_viewport().size.y / 2))
	horizontal_line.add_point(Vector2(get_viewport().size.x, get_viewport().size.y / 2))
	add_child(horizontal_line)

	var vertical_line = Line2D.new()
	vertical_line.width = 2
	vertical_line.default_color = Color(1,1,1,0.3)
	vertical_line.add_point(Vector2(get_viewport().size.x / 2, 0))
	vertical_line.add_point(Vector2(get_viewport().size.x / 2, get_viewport().size.y))
	add_child(vertical_line)
