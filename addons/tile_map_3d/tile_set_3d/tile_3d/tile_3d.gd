@tool
@icon("res://addons/tile_map_3d/tile_set_3d/tile_3d/icon.svg")
## This node is meant to be a child of [TileSet3D].
## If you already have a tile set set up with [MeshInstance3D](s),
## then you can select all the [MeshInstance3D](3) and drag this script into the 'Script' property of them in the inspector.
class_name Tile3D extends MeshInstance3D


## The scene to replace the tile with on run. Null by default.
@export var replace_with: PackedScene = null


## Returns the data of this tile as a [Dictionary], formatted as the following:
## {?scene? = <scene>, ?bitmasks? = <bitmasks>}
## [Tile3D](s) can hold multiple [Bitmask3D](s) as children, allowing the same tile to be placed in various situations.
func get_data() -> Dictionary:
	var bitmasks: Array[Dictionary] = []
	for child in get_children():
		if child is Bitmask3D:
			bitmasks.append(child.get_data())

	var tile_data := {}
	if replace_with != null:
		tile_data.scene = replace_with
	if bitmasks.size() > 0:
		tile_data.bitmasks = bitmasks
	return tile_data
