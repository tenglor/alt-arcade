extends Node2D

@onready var detect_area: Area2D = $DetectArea

var player_check = false

func _ready() -> void:
	detect_area.body_entered.connect(_on_body_entered)
	detect_area.area_entered.connect(_on_area_entered)
	detect_area.area_exited.connect(_on_area_exited)

func _on_body_entered(body) -> void:
	if body.is_in_group("egg"):
		print("Enter egg")
		if player_check and body.can_catch:
			body.queue_free()
		body.can_catch = false;

func _on_body_exited(body) -> void:
	pass

func _on_area_entered(body) -> void:
	if body.is_in_group("player"):
		player_check = true;
		print("Player come")

func _on_area_exited(body) -> void:
	if body.is_in_group("player"):
		print("Player gone")
		player_check = false;

func _process(delta: float) -> void:
	pass
