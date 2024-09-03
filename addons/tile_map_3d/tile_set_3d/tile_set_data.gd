@tool
class_name TileSetData
extends Resource


@export var data: Array[Dictionary] = []


# Might be better to be in TileMap3D
func get_total_priority(tiles: Array[Dictionary]) -> int:
	var total := 0
	for tile in tiles:
		total += tile.priority
	return total
