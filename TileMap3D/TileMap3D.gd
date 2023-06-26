class_name TileMap3D, "res://TileMap3D/Icon.svg"
extends GridMap
tool


export var tile_set := "res://" setget _on_tile_set_set
export var map_seed := 0 setget _on_seed_set
export var _update := false setget _on_update_set

var tile_set_data := []
var _last_cells := []


func _physics_process(_delta: float) -> void:
	if get_used_cells() != _last_cells: #doesn't work properly
		update_map()
		_last_cells = get_used_cells()


func update_map() -> void:
	seed(map_seed)
	for c in get_used_cells():
		auto_tile(c)
		
		if (not Engine.is_editor_hint()) and tile_set_data[get_cell_item(c.x, c.y, c.z)].scene != null:
			var scene: Spatial = tile_set_data[get_cell_item(c.x, c.y, c.z)].scene.instance()
			add_child(scene)
			scene.global_translate(c)
			
			set_cell_item(c.x, c.y, c.z, INVALID_CELL_ITEM)


func auto_tile(what: Vector3) -> void:
	var tiles := []
	
	for t in tile_set_data.size():
		for c in tile_set_data[t].bitmasks:
			var matches := true
			for b in c.bitmask:
				var position: Vector3 = what + b[0]
				
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
				var cell_item := clamp(get_cell_item(position.x, position.y, position.z), -1, 0)
				if cell_item != b[1] - 1:
					matches = false
					break
			
			if matches:
				for p in c.priority: #too heavy
					tiles.append([t, c.orientation])
	
	if tiles.size() > 0:
		tiles.shuffle()
		var tile: Array = tiles.pop_back()
		
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
		set_cell_item(what.x, what.y, what.z, tile[0], tile[1])


# warning-ignore:shadowed_variable
func load_tile_set(tile_set := self.tile_set) -> int:
	var file := File.new()
	var error := file.open(tile_set, file.READ)
	if error == OK:
		tile_set_data = file.get_var(true)
<<<<<<< HEAD
		self.tile_set = tile_set
=======
>>>>>>> afd9c42 (Godot 3 with bugs)
	else:
		push_error("Error " + str(error) + " has occurred when opening file " + tile_set)
	
	file.close()
	update_map()
	return error


func _on_tile_set_set(value: String) -> void:
	tile_set = value
# warning-ignore:return_value_discarded
	load_tile_set()


func _on_update_set(_value: bool) -> void:
	update_map()


func _on_seed_set(value: int) -> void:
	map_seed = value
	update_map()


func _on_TileMap3D_tree_entered() -> void:
# warning-ignore:return_value_discarded
	load_tile_set()
