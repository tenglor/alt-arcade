extends Control

@onready var score_label = $PanelContainer/VBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.set_text("Score: " + str(DifficultyManager.get_score()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
