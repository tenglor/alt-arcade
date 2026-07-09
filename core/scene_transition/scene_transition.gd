extends CanvasLayer

@onready var color_rect := $ColorRect

func _ready() -> void:
	layer = 128
	color_rect.color.a = 0

func start_transition(target_scene: String, spawn_point_id: int, duration: float):

	var fade_in = create_tween()
	fade_in.tween_property(color_rect, "color:a", 1.0, duration * 0.5)
	await fade_in.finished

	var old_room = get_tree().current_scene

	var new_room = load(target_scene).instantiate()
	get_tree().root.add_child(new_room)
	get_tree().current_scene = new_room
	old_room.queue_free()
	#var new_room = load(target_scene)
	#var error = get_tree().change_scene_to_packed(new_room)
	#await wait_for_scene_ready()
		#
	#new_room = get_tree().current_scene
	#var scene_player = new_room.get_node("Player")
	#if scene_player:
		#new_room.remove_child(scene_player)

	var fade_out = create_tween()
	fade_out.tween_property(color_rect, "color:a", 0.0, duration * 0.5)
	await fade_out.finished


func get_player()->CharacterBody2D:
	return get_tree().get_first_node_in_group("player")

func wait_for_scene_ready(timeout: float = 1.0) -> bool:
	var start_time = Time.get_ticks_msec()

	while not get_tree().current_scene:
		#if Time.get_ticks_msec() - start_time > timeout * 1000:
			#push_error("Scene loading timeout")
			#return false

		await get_tree().process_frame

	# Дополнительное ожидание полной инициализации
	await get_tree().create_timer(0.05).timeout
	return true
