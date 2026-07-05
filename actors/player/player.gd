extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detector = get_node("Controller")
	detector.quarter_clicked.connect(quarter_clicked)
	pass # Replace with function body.

func set_sprite(quarter):
	var animation_name = "quarter" + str(quarter)
	animated_sprite.play(animation_name)

func quarter_clicked(quarter)-> void:
	print("Клик в четверти: ", quarter)
	set_sprite(quarter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
