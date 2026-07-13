extends Node

var score = 0
var timeout: float = 3.0
var start_impulse: Vector2 = Vector2.ZERO
var score_impulse_control_points = [5, 10, 20, 30]
var score_time_control_points = [ 10, 20, 30, 50, 70]
var start_impulses = [
	Vector2.ZERO,
	Vector2(100, 0),
	Vector2(200, 0),
	Vector2(400, 0)
	]
var spawn_times = [
	3,
	2.5,
	2,
	1.44,
	1,
	0.7,
	0.5]
var impulse_index = 0
var time_index = 0

func add_score(points: int):
	score += points
	if score in score_impulse_control_points:
		impulse_index+=1
		if impulse_index < start_impulses.size():
			start_impulse = start_impulses[impulse_index]
	if score in score_time_control_points:
		time_index+=1
		if time_index < spawn_times.size():
			timeout = spawn_times[time_index]

func init():
	impulse_index = 0
	time_index = 0
	score = 0
	timeout = 3.0
	start_impulse = Vector2.ZERO

func get_score():
	return score

func get_egg_spawn_time() -> float:
	return timeout

func get_egg_start_impulse() -> Vector2:
	return start_impulse
