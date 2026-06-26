@tool
extends Node

@export var object: Node2D
@export var points: PackedVector2Array = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detector = get_node("Input")
	detector.quarter_clicked.connect(quarter_clicked)
	pass # Replace with function body.

func quarter_clicked(quarter)-> void:
	var pos: Vector2 = points[quarter]
	object.position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw():
	for p in points:
		draw_circle(p, 8, Color.RED)     # Отрисовка каждой точки
		draw_string(ThemeDB.fallback_font, p + Vector2(10, -5), str(p), HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color.WHITE) # Подпись координат
