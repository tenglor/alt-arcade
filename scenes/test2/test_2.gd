extends Node2D

@onready var perch := $Perch

@export_range(0, 10, 0.1) var egg_gravity_scale: float = 1

func _ready() -> void:
	while(true):
		await get_tree().create_timer(3).timeout

		var egg = perch.spawn_egg()
		# egg.mass = 0.4
		egg.gravity_scale = egg_gravity_scale
		add_child(egg)

		await get_tree().create_timer(3).timeout
