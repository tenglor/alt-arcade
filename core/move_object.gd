#@tool
extends Node2D

@export var object: Node2D
@export var points: PackedVector2Array = [Vector2(500, 640), Vector2(650, 640), Vector2(500, 640), Vector2(650, 640)]:
	set(value):
		points = value
		queue_redraw()  # Автоматическая перерисовка

#(540, 640), (650, 640), (500, 640), (650. 640)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detector = get_node("Input")
	detector.quarter_clicked.connect(quarter_clicked)
	queue_redraw()

func quarter_clicked(quarter)-> void:
	var pos: Vector2 = points[quarter]
	object.position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()

func _draw():
	return
	# for i in range(points.size()):
	# 	var p = points[i]
	# 	draw_circle(p, 8, Color.RED)     # Отрисовка каждой точки
	# 	var text_str = str(p) + ", i: " + str(i)
	# 	draw_string(ThemeDB.fallback_font, p + Vector2(10, -5), text_str, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color.WHITE) # Подпись координат
