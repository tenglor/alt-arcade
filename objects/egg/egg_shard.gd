extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(parent_sprite: Sprite2D, texture: Texture2D, shape: Shape2D, pos: Vector2):
	$Sprite2D.texture = texture
	$Sprite2D.scale = parent_sprite.scale
	$Sprite2D.position = parent_sprite.position
	$CollisionShape2D.shape = shape
	position = pos

	await get_tree().create_timer(3.0).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
