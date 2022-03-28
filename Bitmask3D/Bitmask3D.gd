extends GridMap
class_name Bitmask3D, "res://Bitmask3D/Icon.svg"
tool


const _BitmaskTiles := preload("res://Bitmask3D/BitmaskTiles.tres")
const _SPACE := 0.25

export var tile_rotation := Vector3.ZERO
export var priority := 1


func _ready() -> void:
	mesh_library = _BitmaskTiles
	cell_size = Vector3(_SPACE, _SPACE, _SPACE)
	
	cell_center_x = false
	cell_center_y = false
	cell_center_z = false


func get_data() -> Dictionary:
	var bitmask := []
	for i in get_used_cells():
		bitmask.append([i, get_cell_item(i.x, i.y, i.z)])
	var orientation := Basis(Vector3(deg2rad(tile_rotation.x), deg2rad(tile_rotation.y),
			deg2rad(tile_rotation.z))).get_orthogonal_index()
	
	return {"bitmask": bitmask, "orientation": orientation, "priority": priority}
