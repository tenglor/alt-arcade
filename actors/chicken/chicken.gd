extends Node2D

@onready var egg_prefab = preload("res://objects/egg/egg.tscn")
@export var egg_spawn: Vector2 = Vector2.ZERO
var is_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_egg(pos: Vector2):
	# Создаем экземпляр (копию) шаблона
	var egg = egg_prefab.instantiate()
	get_parent().add_child(egg)
	# Устанавливаем его позицию
	egg.position = pos
	egg.apply_central_impulse(Vector2(10, 0))
	egg.apply_torque_impulse(500.0)
	# egg.scale = Vector2.ONE
	# egg.global_scale = Vector2.ONE
	# egg.call_deferred("set_transform", Transform2D.IDENTITY)
	# egg.call_deferred("set_global_position", pos)
	# egg.call_deferred("set_scale", Vector2.ONE)
	# Добавляем в дерево сцены как дочерний узел


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
