extends Node2D

@onready var fire_light := $PointLight2D
@onready var back_wall = $BackWall
@onready var logs = $Firewood
@onready var facade = $Facade
@onready var particles = $GPUParticles2D
var time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 0
	print("z_index: ", z_index)
	print("Относительно ", z_as_relative)
	print("back_wall", back_wall.z_index)
	print("logs", logs)
	print("facade", facade)
	print("fire_light", fire_light)
	print("fire_light.z_index", fire_light.z_index)
	fire_light.range_layer_max = fire_light.z_index + z_index + 1
	# update_z()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if(time > 0.1):
		time = 0
		fire_light.energy = 2.2 + randf() * 0.7
