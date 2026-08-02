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

func spawn_egg() -> Node2D:
	# Создаем экземпляр (копию) шаблона
	var egg = egg_prefab.instantiate()
	# Устанавливаем его позицию
	egg.position = position
	return egg

func get_roost_rotation() -> float:
	return $StaticBody2D.rotation_degrees

func _on_area_entered(body) -> void:
	if body.is_in_group("player"):
		player_check = true;

func _on_area_exited(body) -> void:
	if body.is_in_group("player"):
		player_check = false;

func _process(delta: float) -> void:
	pass
