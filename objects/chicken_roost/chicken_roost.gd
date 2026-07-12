extends Node2D

@onready var detect_area: Area2D = $DetectArea
@onready var egg_prefab = preload("res://objects/egg/egg.tscn")

var player_check = false

func _ready() -> void:
	detect_area.body_entered.connect(_on_body_entered)
	detect_area.area_entered.connect(_on_area_entered)
	detect_area.area_exited.connect(_on_area_exited)

func _on_body_entered(body) -> void:
	if body.is_in_group("egg"):
		if player_check and body.can_catch:
			body.catch()
		body.can_catch = false;

func _on_body_exited(body) -> void:
	pass

func spawn_egg(pos: Vector2) -> Node2D:
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
	return egg

func _on_area_entered(body) -> void:
	if body.is_in_group("player"):
		player_check = true;

func _on_area_exited(body) -> void:
	if body.is_in_group("player"):
		player_check = false;

func _process(delta: float) -> void:
	pass
