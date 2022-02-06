extends Camera2D

func _ready():
	var map = get_tree().get_nodes_in_group("Map")[0]
	var mapRect = map.get_used_rect()
	var cellSize = map.cell_size
	limit_left = mapRect.position.x * cellSize.x
	limit_top = mapRect.position.y * cellSize.y
	limit_right = mapRect.end.x * cellSize.x
	limit_bottom = mapRect.end.y * cellSize.y
