extends Node2D

@onready var egg_prefab = preload("res://objects/egg/egg.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_enemy(location: Vector2):
    # Создаем экземпляр (копию) шаблона
    var egg_instance = egg_prefab.instantiate()
    # Устанавливаем его позицию
    egg_instance.position = location
    # Добавляем в дерево сцены как дочерний узел
    add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
