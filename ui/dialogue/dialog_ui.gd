extends Control

@onready var text_box := $VBoxContainer/DialogBox/Text
@onready var character_box := $VBoxContainer/CharacterBox/Character

func _ready() -> void:
	assert(text_box)
	assert(character_box)

func set_text2(charater: String, text: String)->void:
	character_box.text = charater
	text_box.text = text

func set_text(dialog_data: Dictionary)->void:
	character_box.text = dialog_data.get("charater", "???")
	text_box.text = dialog_data.get("text", "...")
