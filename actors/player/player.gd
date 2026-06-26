extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detector = get_node("Controller")
	detector.quarter_clicked.connect(quarter_clicked)
	pass # Replace with function body.


func quarter_clicked(quarter)-> void:
	print("Клик в четверти: ", quarter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
