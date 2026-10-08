extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var basket: Area2D = $Basket
@onready var current_shape: CollisionShape2D = $Basket/shape0
@onready var current_quarter = -1

@export var positions: Array[Node2D]

var detector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detector = get_node("Controller")
	detector.quarter_clicked.connect(quarter_clicked)
	basket.body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body:Node2D):
	if not body is StaticBody2D:
		print("Тело вошло: ", body.name)

func set_sprite(quarter):
	if current_quarter >= 0 and current_quarter != quarter:
		var end_animation_name = "quarter" + str(current_quarter)
		animated_sprite.play_backwards(end_animation_name)
		await animated_sprite.animation_finished
	var animation_name = "quarter" + str(quarter)
	animated_sprite.play(animation_name)
	current_shape.disabled = true
	current_shape = get_node("Basket/shape" + str(quarter))
	current_shape.disabled = false
	current_quarter = quarter


func move_to(target_position: Vector2, time: float):
	var tween = create_tween()
	tween.tween_property(
		self,
		"position",
		target_position,
		0.1
	)

func quarter_clicked(quarter: int)-> void:
	print("Click to %d from %d" % [quarter, current_quarter])
	if current_quarter != quarter:
		if current_quarter >= 0:
			print("end animation")
			var end_animation_name = "quarter" + str(current_quarter)
			animated_sprite.play(end_animation_name)
			# if positions.size() == 4:
				# var frames = animated_sprite.sprite_frames
				# var frame_count = frames .get_frame_count(end_animation_name)
				# var fps = frames.get_animation_speed(end_animation_name)
				# var duration = frame_count / fps
				# move_to(positions[quarter].position, 0.05)
			await animated_sprite.animation_finished
		if positions.size() == 4:
			self.position = positions[quarter].position
			# if abs(current_quarter - quarter) == 1:
			# 	move_to(positions[quarter].position, 0.05)
			# else:
			# 	self.position = positions[quarter].position
		current_quarter = quarter
		var animation_name = "quarter" + str(quarter)
		print("start animation")
		animated_sprite.play_backwards(animation_name)
		current_shape.disabled = true
		current_shape = get_node("Basket/shape" + str(quarter))
		current_shape.disabled = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
