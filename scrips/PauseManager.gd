extends Node
# class_name PauseManager

var is_paused: bool = false

# Список узлов, которые должны ИГНОРИРОВАТЬ паузу
static var ignore_pause_nodes: Array[Node] = []

func toggle_pause():
	if is_paused:
		resume_game()
	else:
		pause_game()

func pause_game():
	if is_paused:
		return

	is_paused = true
	get_tree().paused = true

	# Прячем курсор (опционально)
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func resume_game():
	if not is_paused:
		return

	is_paused = false
	get_tree().paused = false
	# Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Добавляем узел в "белый список" для игнорирования паузы
func add_ignore_pause(node: Node):
	node.process_mode = Node.PROCESS_MODE_ALWAYS
	# if node not in ignore_pause_nodes:
	# 	ignore_pause_nodes.append(node)
	# 	# Устанавливаем процесс мод, который игнорирует паузу
	# 	node.process_mode = Node.PROCESS_MODE_ALWAYS

func remove_ignore_pause(node: Node):
	node.process_mode = Node.PROCESS_MODE_INHERIT
	# if node in ignore_pause_nodes:
	# 	ignore_pause_nodes.erase(node)
	# 	node.process_mode = Node.PROCESS_MODE_INHERIT
