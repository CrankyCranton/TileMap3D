@tool
@icon("res://addons/tile_map_3d/tile_set_3d/tile_3d/bitmask_3d/icon.svg")
## Defines a situation where the tile can be placed based on the surounding tiles.
## Blue blobs mean there must be no tile in that cell, and red means there must be one. Empty means ignore.
class_name Bitmask3D
extends GridMap


const BITMASK_TILES := preload("res://addons/tile_map_3d/tile_set_3d/tile_3d/bitmask_3d/bitmask_tiles.meshlib")
const SPACING := 0.25

## The rotation of what the tile's mesh should be at when placed.
@export var tile_rotation := Vector3.ZERO:
	set(value):
		tile_rotation = value.snapped(Vector3.ONE * 90.0)
## If conflits occurre on what tile to place, then the higher this number is, the more likly it will be placed.
@export var priority := 1:
	set(value):
		priority = max(0, value)


func _ready() -> void:
	mesh_library = BITMASK_TILES
	cell_size = Vector3(SPACING, SPACING, SPACING)
	cell_center_x = false
	cell_center_y = false
	cell_center_z = false


## Returns the [Bitmask3D]'s data. The format the data is in is this:
## {orientation = <orientation>, priority = <priority>, ?bitmask? = <bitmask>}
func get_data() -> Dictionary:
	var bitmask := {}
	for cell in get_used_cells():
		bitmask[cell] = get_cell_item(cell)

	var orientation := get_orthogonal_index_from_basis(Basis.from_euler(
		Vector3(
			deg_to_rad(tile_rotation.x),
			deg_to_rad(tile_rotation.y),
			deg_to_rad(tile_rotation.z),
	)))

	var data := {"orientation" = orientation, "priority" = priority}
	if bitmask.size() > 0:
		data.bitmask = bitmask
	return data
