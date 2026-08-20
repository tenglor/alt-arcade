extends Node

var score = 0
var egg_gravity_scale_values = [0.5, 1, 1.5, 1.7, 1.85, 2]
var egg_gravity_scale_points = [100, 120, 150, 200, 300, 500]
var egg_gravity_scale = egg_gravity_scale_values[0]
var scale_index = 0
var score_time_control_points = [ 10, 20, 30, 50, 70]
var spawn_times = [
	5,
	4,
	3,
	2,
	1.5
	]
var timeout: float = spawn_times[0]
var time_index = 0

func add_score(points: int):
	score += points
	if score in score_time_control_points:
		time_index+=1
		if time_index < spawn_times.size():
			timeout = spawn_times[time_index]
	if score in egg_gravity_scale_points:
		scale_index += 1
		if score < egg_gravity_scale_values.size():
			egg_gravity_scale = egg_gravity_scale_values[scale_index]

func reset():
	time_index = 0
	scale_index = 0
	timeout = spawn_times[0]
	egg_gravity_scale = egg_gravity_scale_values[0]


func get_score():
	return score

func get_egg_spawn_time() -> float:
	return timeout

func get_gravity_scale() -> float:
	return egg_gravity_scale;
