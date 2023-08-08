@tool
@icon("res://addons/tile_map_3d/tile_set_3d/icon.svg")
class_name TileSet3D
extends Node3D


## Whether to auto-generate colliders.
@export var has_colliders := false:
	set(value):
		has_colliders = value
		for t in get_children():
			if t is MeshInstance3D:
				add_collider(t) if has_colliders else delete_collider(t)
## If true, the collision shapes will be generated as convex. If false (default), they will be concave.
## Only takes affect if 'has_colliders' is set to true.
@export var convex_collisions := false:
	set(value):
		convex_collisions = value
		has_colliders = has_colliders

## Used to space-out tiles to make them more visible for editing. Messured in meters.
@export var spacing := 0.0:
	set(value):
		spacing = value
		sort_tiles(spacing)

## The directory to export the tile set data to.
@export_dir var export_path := "res://"
## The name if the exported file.
@export var file_name := ""

@export var _export := false:
	set(_value):
		export_tile_set_data()


## Sorts the tile positions with the given spacing.
func sort_tiles(spacing: int) -> void:
	var tiles := get_children().filter(func(value: Node): return value is MeshInstance3D)
	var width := int(floor(sqrt(tiles.size())))
	var height := int(ceil(sqrt(tiles.size())))
	var index := 0
	for x in width:
		for z in height:
			tiles[index].global_position = Vector3(x, 0.0, z) * spacing
			index += 1


## Clears the colliders on 'of', and then creates one based on 'convex_collisions'. This is used by the 'has_colliders' setter function.
func add_collider(to: MeshInstance3D) -> void:
	delete_collider(to)
	to.create_convex_collision() if convex_collisions else to.create_trimesh_collision()


## Deletes all direct children on 'of' that are StaticBody3D(s). This is used by the 'has_colliders' setter function.
func delete_collider(of: MeshInstance3D) -> void:
	for c in of.get_children():
		if c is StaticBody3D:
			c.queue_free()


## Exports the tile set data as a resource using 'export_path' and 'file_name'.
func export_tile_set_data() -> void:
	var file_path := export_path
	if not file_path.ends_with("/"):
		file_path += "/"
	file_path += file_name

	var tile_set_data: TileSetData
	if ResourceLoader.exists(file_path):
		tile_set_data = ResourceLoader.load(file_path)
	else:
		tile_set_data = TileSetData.new()
	tile_set_data.data = get_tile_set_data()

	var error := ResourceSaver.save(tile_set_data, file_path)
	if error != OK:
		push_error("Error {0} occurred when creating resource {1}".format([error, file_path]))


## Returns the tile set data.
func get_tile_set_data() -> Array[Dictionary]:
	var tile_set_data: Array[Dictionary] = []
	for child in get_children():
		if child is Tile3D:
			tile_set_data.append(child.get_data())
	return tile_set_data
