extends Node2D

var quarter := 0

var input_enable = true

signal quarter_clicked(quarter_number)

@onready var input_mask = 0xF

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true)

func _input(event):
	if !input_enable:
		return
	var quarter_changed = false
	if event is InputEventKey:
		var quarter_bit = 0x1
		if event.keycode == KEY_Q:
			quarter_changed = true
			quarter = 0
		elif event.keycode == KEY_E:
			quarter_changed = true
			quarter = 1
			quarter_bit = quarter_bit << 1
		elif event.keycode == KEY_A:
			quarter_changed = true
			quarter = 2
			quarter_bit = quarter_bit << 2
		elif event.keycode == KEY_D:
			quarter_changed = true
			quarter = 3
			quarter_bit = quarter_bit << 3

		if quarter_changed and input_mask & quarter_bit:
			quarter_clicked.emit(quarter)


func touched() -> bool:
	return true;
