extends Node

var test_scene = "res://scenes/test/test.tscn"
var tutorial_scene = "res://scenes/tutorial/tutorial.tscn"
var main_menu  = "res://ui/main_menu/main_menu.tscn"
var loading = "res://ui/loading/loading.tscn"

var tutorial_offer = true

var thread: Thread
func load_scene(target_scene) -> void:
	# var target_scene = "res://scenes/test.tscn"
	var old_room = get_tree().current_scene

	var loading_screen = load(loading).instantiate()
	get_tree().root.add_child(loading_screen)
	get_tree().current_scene = loading_screen
	old_room.hide()

	await RenderingServer.frame_post_draw


	var t = Time.get_ticks_msec()
	ResourceLoader.load_threaded_request(target_scene)
	# print("load_threaded_request ", Time.get_ticks_msec() - t)
	while true:
		var status = ResourceLoader.load_threaded_get_status(target_scene)

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			break
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Не удалось загрузить сцену")
			return
		await get_tree().process_frame
		# await RenderingServer.frame_post_draw

	t = Time.get_ticks_msec()
	var packed_scene = ResourceLoader.load_threaded_get(target_scene)

	print("get resource: ", Time.get_ticks_msec() - t, " ms")

	t = Time.get_ticks_msec()
	var new_room
	if target_scene != test_scene:
		new_room = packed_scene.instantiate()
	else:
		# new_room = Node2D.new()
		new_room = packed_scene.instantiate()

	print("instantiate: ", Time.get_ticks_msec() - t, " ms")

	# Создаём Node в отдельном потоке.
	# thread = Thread.new()
	# thread.start(_instantiate_scene.bind(packed_scene))

	# # Пока Thread работает, главный поток продолжает рисовать loading screen.
	# while thread.is_alive():
	# 	await get_tree().process_frame

	# var new_room = thread.wait_to_finish()

	t = Time.get_ticks_msec()
	get_tree().root.add_child(new_room)
	get_tree().current_scene = new_room
	print("add_child: ", Time.get_ticks_msec() - t, " ms")

	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame

	# t = Time.get_ticks_msec()
	old_room.queue_free()
	# print("old_room queue_free: ", Time.get_ticks_msec() - t, " ms")

	# t = Time.get_ticks_msec()
	loading_screen.queue_free()
	# print("loading_screen queue_free: ", Time.get_ticks_msec() - t, " ms")

func _instantiate_scene(packed_scene: PackedScene) -> Node:
	return packed_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
