extends Node2D

@export var chicken_roosts: Array[Node2D]
@onready var score: int = 0
@onready var hud: HUD = $"../HUD"
# var hud: HUD
@onready var hp_counter = 0

var rng = RandomNumberGenerator.new()
var is_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hud = get_parent().get_child("HUD")
	hud.set_score(score)

func _on_timer_timeout():
	var i = rng.randi_range(0, 3)
	var chicken = chicken_roosts[i]
	var egg = chicken.spawn_egg(chicken.position)
	egg.crashed.connect(_on_egg_crashed)
	egg.caught.connect(_on_egg_caught)
	is_timeout = false

func _on_egg_caught() -> void:
	score+=1
	hud.set_score(score)

func _on_egg_crashed() -> void:
	hud.crush_egg(hp_counter)
	hp_counter+=1
	pass


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
