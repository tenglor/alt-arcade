extends Node2D

@export var chicken_roosts: Array[Node2D]
var rng = RandomNumberGenerator.new()
var is_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_timer_timeout():
	var i = rng.randi_range(0, 3)
	var chicken = chicken_roosts[i]
	chicken.spawn_egg(chicken.position)
	is_timeout = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_timeout:
		return
	# print("Создание таймера")
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
