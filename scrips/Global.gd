extends Node

func load_scene(target_scene) -> void:
	# var target_scene = "res://scenes/test.tscn"
	var old_room = get_tree().current_scene

	var new_room = load(target_scene).instantiate()
	get_tree().root.add_child(new_room)
	get_tree().current_scene = new_room
	old_room.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
