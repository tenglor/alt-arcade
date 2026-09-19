extends Node

var difficulty_dict: Array[Dictionary] = [
	{"gravity": 0.7, "timeout": 3},
	{"gravity": 0.7, "timeout": 2},
	{"gravity": 0.7, "timeout": 1.5},
	{"gravity": 0.7, "timeout": 1.25},
	{"gravity": 1,   "timeout": 1.25},
	{"gravity": 1,   "timeout": 1},
	{"gravity": 1.2, "timeout": 1},
	{"gravity": 1.4, "timeout": 1},
	{"gravity": 1.6, "timeout": 1},
	{"gravity": 1.8, "timeout": 1},
	{"gravity": 1.8, "timeout": 0.8},
	{"gravity": 2,   "timeout": 0.8},
	{"gravity": 2,   "timeout": 0.7},
]
var index = 0
var score = 0
var control_points = [ 5, 10, 15, 25, 30, 35, 40, 45, 50, 55, 60, 70]
var egg_gravity_scale: float
var timeout: float

func add_score(points: int):
	score += points
	if score in control_points:
		index += 1
		if index < difficulty_dict.size():
			print("Warning: difficulty_dict[", index, "] not existed")
		timeout = difficulty_dict[index]["timeout"]
		egg_gravity_scale = difficulty_dict[index]["gravity"]

func reset():
	index = 0
	timeout = difficulty_dict[index]["timeout"]
	egg_gravity_scale = difficulty_dict[index]["gravity"]


func get_score():
	return score

func get_egg_spawn_time() -> float:
	return timeout

func get_gravity_scale() -> float:
	return egg_gravity_scale;
