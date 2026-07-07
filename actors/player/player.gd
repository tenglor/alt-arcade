extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var basket: Area2D = $Basket
@onready var current_shape: CollisionShape2D = $Basket/shape0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detector = get_node("Controller")
	detector.quarter_clicked.connect(quarter_clicked)
	basket.body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body:Node2D):
	if not body is StaticBody2D:
		print("Тело вошло: ", body.name)

func set_sprite(quarter):
	var animation_name = "quarter" + str(quarter)
	animated_sprite.play(animation_name)
	current_shape.disabled = true
	current_shape = get_node("Basket/shape" + str(quarter))
	current_shape.disabled = false


func quarter_clicked(quarter)-> void:
	print("Клик в четверти: ", quarter)
	set_sprite(quarter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
