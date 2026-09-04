extends Node2D

@export var dialogue: DialogueResource

func _ready() -> void:
	interact()

func interact():
	DialogueManager.show_dialogue_balloon(dialogue, "start")
