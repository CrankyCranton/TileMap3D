class_name Tile, "res://Tile/TileIcon.svg"
extends MeshInstance
tool


export var replace_with: PackedScene = null


func get_data() -> Dictionary:
	var tile_data := {"scene": replace_with, "bitmasks": []}
	
	for b in get_children():
		if b is Bitmask3D:
			tile_data.bitmasks.append(b.get_data())
	
	return tile_data
