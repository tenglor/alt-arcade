extends Node2D

@onready var egg_prefab = preload("res://objects/egg/egg.tscn")
@export var egg_spawn: Vector2 = Vector2.ZERO
var is_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_enemy(location: Vector2):
	# Создаем экземпляр (копию) шаблона
	var egg_instance = egg_prefab.instantiate()
	# Устанавливаем его позицию
	# egg_instance.position = location
	egg_instance.position = egg_spawn
	egg_instance.apply_central_impulse(Vector2(10, 0))
	egg_instance.apply_torque_impulse(500.0)
	# Добавляем в дерево сцены как дочерний узел
	add_child(egg_instance)

func _on_timer_timeout():
	spawn_enemy(Vector2.ZERO)
	is_timeout = false
	print("Прошло 3 секунды!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_timeout:
		return 
	print("Создание таймера")
	is_timeout = true
	# Создаем новый таймер
	var timer = Timer.new()
	# Добавляем его в сцену
	add_child(timer)
	# Устанавливаем интервал в 10 секунд
	timer.wait_time = 3.0
	timer.one_shot = true
	# Автоматически запускаем при входе в дерево сцены
	timer.start()
	# Подключаем сигнал timeout к функции
	timer.timeout.connect(_on_timer_timeout)
