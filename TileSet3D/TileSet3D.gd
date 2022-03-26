class_name TileSet3D, "res://TileSet3D/Icon.svg"
extends Spatial
tool


export var convex_collisions := false setget _on_convex_collisions_set
export var has_colliders := false setget _on_has_colliders_set
export var step := 0.0 setget _on_step_set
export var _export := false setget _on_export_set
export var export_path := "res://"
export var file_name := ""


func add_collider(to: MeshInstance) -> void:
	delete_collider(to)
# warning-ignore: standalone_ternary
	to.create_convex_collision() if convex_collisions else to.create_trimesh_collision()


func delete_collider(of: MeshInstance) -> void:
	for c in of.get_children():
		if c is StaticBody:
			c.queue_free()


# warning-ignore:function_conflicts_variable
func export_tile_set_data() -> void:
	var diretory := Directory.new()
	if not diretory.dir_exists(export_path):
		push_error("Directory " + export_path + " dose not exist.")
	
	var file := File.new()
	var file_path := export_path + file_name
	var error := file.open(file_path, file.WRITE)
	if error == OK:
		file.store_var(get_tile_set_data())
	else:
		push_error("Error " + str(error) + " occurred when making file " + file_path)
	
	file.close()


func get_tile_set_data() -> Array:
	var tile_set_data := []
	
	for t in get_children():
		if t is Tile:
			tile_set_data.append(t.get_data())
	return tile_set_data


func _on_convex_collisions_set(value: bool) -> void:
	convex_collisions = value
	self.has_colliders = has_colliders


func _on_has_colliders_set(value: bool) -> void:
	has_colliders = value
	for t in get_children():
		if t is MeshInstance:
# warning-ignore: standalone_ternary
			add_collider(t) if value else delete_collider(t)


func _on_step_set(value: float) -> void:
	step = value
	var curent_position: float = -get_child_count() / 2.0 * step
	for t in get_children():
		if t is MeshInstance:
			t.translation = Vector3.RIGHT * curent_position
			curent_position += step


func _on_export_set(_value: bool) -> void:
	export_tile_set_data()
