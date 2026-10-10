class_name Chicken
extends Node2D

enum State {
	NORMAL,
	TENSE
}

const sprite_normal = preload("res://actors/chicken/chicken.png")
const sprite_tense = preload("res://actors/chicken/chicken2.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_state(state: State) -> void:
	if state == State.NORMAL:
		$Sprite2D.texture = sprite_normal
	elif state == State.TENSE:
		$Sprite2D.texture = sprite_tense

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
