extends Node

var score = 0
var timeout: float = 3.0
var start_impulse: Vector2 = Vector2.ZERO
var score_control_points = [5, 10, 20, 30, 50, 100]
var start_impulses = [
	Vector2.ZERO,
	Vector2(100, 0),
	Vector2(200, 0),
	Vector2(400, 0),
	Vector2(800, 0)]
var index = 0

func add_score(points: int):
	score += points
	if score in score_control_points:
		index+=1
	if index < start_impulses.size():
		start_impulse = start_impulses[index]

func init():
	index = 0
	score = 0
	timeout = 3.0
	start_impulse = Vector2.ZERO

func get_score():
	return score

func get_egg_spawn_time() -> float:
	return timeout

func get_egg_start_impulse() -> Vector2:
	return start_impulse
