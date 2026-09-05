extends Node

var test_scene = "res://scenes/test/test.tscn"
var tutorial_scene = "res://scenes/tutorial/tutorial.tscn"
var main_menu  = "res://ui/main_menu/main_menu.tscn"
var loading = "res://ui/loading/loading.tscn"

var tutorial_offer = true

func load_scene(target_scene) -> void:
	# var target_scene = "res://scenes/test.tscn"
	var old_room = get_tree().current_scene

	var loading_screen = load(loading).instantiate()
	get_tree().root.add_child(loading_screen)
	get_tree().current_scene = loading_screen
	old_room.hide()

	await RenderingServer.frame_post_draw

	old_room.queue_free()
	ResourceLoader.load_threaded_request(target_scene)
	while true:
		var status = ResourceLoader.load_threaded_get_status(target_scene)

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			break
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Не удалось загрузить сцену")
			return

		await get_tree().process_frame
	var new_room = ResourceLoader.load_threaded_get(target_scene).instantiate()
	get_tree().root.add_child(new_room)
	get_tree().current_scene = new_room

	loading_screen.queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
