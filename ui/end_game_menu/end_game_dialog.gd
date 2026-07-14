extends Control

@onready var score_label = $PanelContainer/VBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if visible:
			score_label.set_text("Score: " + str(DifficultyManager.get_score()))

func _on_restart_button_pressed()-> void:
	get_tree().paused = false
	Global.load_scene(Global.test_scene)

func _on_return_button_pressed()->void:
	get_tree().paused = false
	Global.load_scene(Global.main_menu)
