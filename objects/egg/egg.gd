@tool
extends RigidBody2D

enum Type {
	NORMAL,
	ROTTEN
}
var can_catch = true

var sharp = preload("res://objects/egg/egg_shard.tscn")
signal crashed
signal caught

var initial_impulse: Vector2

@onready var sprite:=$Sprite2D

var _type: Type = Type.NORMAL
@export var type: Type = Type.NORMAL :
	get:
		return _type
	set(value):
		_type = value
		_update_egg_sprite()
		notify_property_list_changed()

func _update_egg_sprite():
	if not sprite:
		# Если спрайт еще не загружен, пробуем найти его
		sprite = $Sprite2D
		if not sprite:
			return
	print("sprite: ", sprite)
	match _type:
		Type.NORMAL:
			sprite.modulate = Color(1, 1, 1)
		Type.ROTTEN:
			sprite.modulate = Color(0.5, 0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_egg_sprite()
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 1
	caught.connect(AudioManager.catch_sound)
	crashed.connect(AudioManager.crash_sound)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("floor"):
		# call_deferred("spawn_sharps")
		spawn_sharps()

func catch() -> void:
	caught.emit()
	queue_free()

func spawn_sharps() -> void:
	var left = sharp.instantiate()
	var right = sharp.instantiate()
	get_parent().add_child(left)
	get_parent().add_child(right)
	left.apply_impulse(Vector2(-100, 0))
	right.apply_impulse(Vector2(100, 0))
	var left_texture = load("res://objects/egg/egg2.png")
	var right_texture = load("res://objects/egg/egg1.png")
	var left_shape = load("res://objects/egg/egg_shape_left.tres")
	var right_shape = load("res://objects/egg/egg_shape_right.tres")
	left.setup($Sprite2D, left_texture, left_shape, position + Vector2(0, -1))
	right.setup($Sprite2D,right_texture, right_shape, position + Vector2(0, -1))
	crashed.emit()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# print(linear_velocity)
	pass
