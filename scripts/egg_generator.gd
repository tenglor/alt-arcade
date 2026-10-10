extends Node2D

@onready var chicken_roosts: Array[Node2D]
@onready var score: int = 0
@onready var hud: HUD = $"../HUD"
# var hud: HUD
@onready var hp_counter = 0
@export var roost: Node2D
@export var egg_parent: Node = self

var rng = RandomNumberGenerator.new()
var is_timeout = false

@export var enable_generating = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hud = get_parent().get_child("HUD")
	hud.set_score(score)

	chicken_roosts.append(roost.get_node("Perch0"))
	chicken_roosts.append(roost.get_node("Perch1"))
	chicken_roosts.append(roost.get_node("Perch2"))
	chicken_roosts.append(roost.get_node("Perch3"))

	# var timer = Timer.new()
	# # Добавляем его в сцену
	# add_child(timer)

	if enable_generating:
		deferred_spawn(2)

func _on_timer_timeout(timer_timeout):
	var i = rng.randi_range(0, 3)
	var chicken = chicken_roosts[i]
	# chicken.get_node("Chicken").set_state(Chicken.State.TENSE)
	# await get_tree().create_timer(timer_timeout / 2).timeout
	# chicken.get_node("Chicken").set_state(Chicken.State.NORMAL)
	var egg = chicken.spawn_egg()
	egg.z_index = egg.z_index + 2
	egg.crashed.connect(_on_egg_crashed)
	egg.caught.connect(_on_egg_caught)
	# if randf() > 0.05:
	# 	egg.crashed.connect(_on_egg_crashed)
	# 	egg.caught.connect(_on_egg_caught)
	# else:
	# 	egg.rotten = true
	# 	egg.caught.connect(_on_egg_crashed)
	egg_parent.add_child(egg)
	egg.gravity_scale = DifficultyManager.get_gravity_scale()
	is_timeout = false

func _on_egg_caught() -> void:
	DifficultyManager.add_score(1)
	hud.set_score(DifficultyManager.get_score())

func _on_egg_crashed() -> void:
	hud.crush_egg(hp_counter)
	hp_counter+=1
	pass

func deferred_spawn(timer_timeout: float):
	# Создаем новый таймер
	is_timeout = true
	var timer = Timer.new()
	# Добавляем его в сцену
	add_child(timer)

	# timer.wait_time = timer_timeout / 2
	timer.wait_time = timer_timeout
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout.bind(timer_timeout))

	# Автоматически запускаем при входе в дерево сцены
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_timeout or not enable_generating:
		return
	# print("Создание таймера")
	deferred_spawn(DifficultyManager.get_egg_spawn_time())
