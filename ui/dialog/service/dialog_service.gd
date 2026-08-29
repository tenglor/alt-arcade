extends Node2D

@onready var dialog_preload := preload("res://ui/dialog/dialog_ui.tscn")

var dialog = null
var scene: Node2D

var conversation
var current_index: int

var is_dialog = false

signal dialog_started()
signal dialog_finished()

var delay := 0.01

func _ready() -> void:
	pass


func get_input():
	if(Input.is_action_just_pressed("use")):
		end_dialog()

func _input(event: InputEvent) -> void:
	if(is_dialog and Input.is_action_just_pressed("use")):
		current_index = current_index + 1
		var t = conversation.get(current_index)
		if t:
			dialog.set_text(t["character"], t["text"])
		else:
			end_dialog()



func begin_dialog(dialogue_json: JSON, id: String):
	await get_tree().create_timer(delay).timeout
	conversation = dialogue_json.data[id]
	current_index = 0
	is_dialog = true

	dialog = dialog_preload.instantiate()
	var ui_root = get_viewport().get_camera_2d().get_node("CanvasLayer/UIRoot")
	ui_root.add_child(dialog)

	dialog.set_text(conversation[current_index]["character"], conversation[current_index]["text"])
	emit_signal("dialog_started")



func end_dialog():
	await get_tree().create_timer(delay).timeout
	is_dialog = false
	dialog.free()
	dialog = null
	emit_signal("dialog_finished")
