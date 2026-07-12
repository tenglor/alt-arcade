class_name HUD
extends CanvasLayer

@onready var score_label = $ScoreLabel
var hp: int = 0
@export var max_hp: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_score(score: int) -> void:
	score_label.set_text("Score: " + str(score))

func crush_egg(i: int) -> void:
	var broken_egg = load("res://objects/egg/broken_egg.png")
	if i < max_hp:
		var texture_rect = get_node("HPContainer/TextureRect" + str(i))
		texture_rect.texture = broken_egg
	if i == max_hp - 1:
		Global.load_scene("res://ui/main_menu/main_menu.tscn")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
