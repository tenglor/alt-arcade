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
	$AnimatedSprite2D.play("default")
	# fire_light.range_layer_max = fire_light.z_index + z_index + 1
	# update_z()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if(time > 0.1):
		time = 0
		fire_light.energy = 2.2 + randf() * 0.7
