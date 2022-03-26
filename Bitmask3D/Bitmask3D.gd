extends GridMap
class_name Bitmask3D, "res://Bitmask3D/Icon.svg"
tool


const BitmaskTiles := preload("res://Bitmask3D/BitmaskTiles.tres")
const space := 0.25

export var _rotation := Vector3.ZERO
export var priority := 1


func _ready() -> void:
	mesh_library = BitmaskTiles
	cell_size = Vector3(space, space, space)
	
	cell_center_x = false
	cell_center_y = false
	cell_center_z = false


func get_data() -> Dictionary:
	var bitmask := []
	for i in get_used_cells():
		bitmask.append([i, get_cell_item(i.x, i.y, i.z)])
	var orientation := Basis(Vector3(deg2rad(_rotation.x), deg2rad(_rotation.y),
			deg2rad(_rotation.z))).get_orthogonal_index()
	
	return {"bitmask": bitmask, "orientation": orientation, "priority": priority}
