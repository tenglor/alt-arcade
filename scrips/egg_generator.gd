extends Node2D

@onready var chicken_roosts: Array[Node2D]
@onready var score: int = 0
@onready var hud: HUD = $"../HUD"
# var hud: HUD
@onready var hp_counter = 0
@onready var roost = $"../Roost"

var rng = RandomNumberGenerator.new()
var is_timeout = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# hud = get_parent().get_child("HUD")
	hud.set_score(score)

	chicken_roosts.append(roost.get_node("Perch0"))
	chicken_roosts.append(roost.get_node("Perch1"))
	chicken_roosts.append(roost.get_node("Perch2"))
	chicken_roosts.append(roost.get_node("Perch3"))

func _on_timer_timeout():
	var i = rng.randi_range(0, 3)
	var chicken = chicken_roosts[i]
	var egg = chicken.spawn_egg()
	get_parent().add_child(egg)
	egg.crashed.connect(_on_egg_crashed)
	egg.caught.connect(_on_egg_caught)
	var roost_rotation = chicken.get_roost_rotation()
	print("roost_rotation: " + str(roost_rotation))
	if chicken.scale.x >= 0:
		var impulse = DifficultyManager.get_egg_start_impulse().rotated(deg_to_rad(roost_rotation))
		print(">: impulse: " + str(impulse))
		egg.apply_central_impulse(Vector2.RIGHT * impulse)
		# egg.apply_torque_impulse(500.0)
	else:
		var impulse = DifficultyManager.get_egg_start_impulse().rotated(deg_to_rad(roost_rotation))
		print("<: impulse: " + str(impulse))
		egg.apply_central_impulse(Vector2.LEFT * impulse)
		# egg.apply_torque_impulse(-500.0)
	is_timeout = false

func _on_egg_caught() -> void:
	DifficultyManager.add_score(1)
	hud.set_score(DifficultyManager.get_score())

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

	timer.wait_time = DifficultyManager.get_egg_spawn_time()
	timer.one_shot = true
	# Автоматически запускаем при входе в дерево сцены
	timer.start()
	# Подключаем сигнал timeout к функции
	timer.timeout.connect(_on_timer_timeout)
