## This should be the root node to a scene used to generate a [MeshLibrary].
## If you already have a tile set scene set up, then you can change the script of the root node to 'tile_set_3d.gd'
@tool
@icon("res://addons/tile_map_3d/tile_set_3d/icon.svg")
class_name TileSet3D extends Node3D


enum CollisionType {
	SIMPLIFIED_CONVEX,
	CONVEX,
	MULTIPLE_CONVEX,
	TRIMESH,
}

## Used to space-out tiles to make them more visible for editing. Messured in meters.
@export var spacing := 0.0:
	set(value):
		spacing = value
		sort_tiles(spacing)

@export_group("Collision")
## Whether to auto-generate colliders.
@export var has_colliders := false:
	set(value):
		has_colliders = value
		add_collider(self) if has_colliders else delete_collider(self)
## The type of collision shapes to be generated.
## Only takes affect if 'has_colliders' is set to true.
@export var collision_type: CollisionType = 1:
	set(value):
		collision_type = value
		has_colliders = has_colliders

@export_group("Export")
## The directory to export the tile set data to.
@export_dir var export_path := "res://"
## The name of the exported file.
@export var file_name := ""

@export var _export := false:
	set(_value):
		export_tile_set_data()
@export_group("")


## Sorts the tile positions with the given spacing.
func sort_tiles(spacing: float) -> void:
	var tiles := get_children()#.filter(func(value: Node): return value is MeshInstance3D)
	var width := int(ceil(sqrt(tiles.size())))
	var height := int(ceil(sqrt(tiles.size())))
	var index := 0
	for x in width:
		for z in height:
			tiles[index].global_position = Vector3(-x, 0.0, -z) * spacing
			index += 1


## Clears the colliders on 'node', and then creates new ones based on 'collision_type'.
## This is used by the 'has_colliders' setter function.
func add_collider(node: Node) -> void:
	var create_collision := func(mesh: MeshInstance3D) -> void:
		match collision_type:
			CollisionType.SIMPLIFIED_CONVEX:
				node.create_convex_collision(true, true)
			CollisionType.CONVEX:
				node.create_convex_collision()
			CollisionType.MULTIPLE_CONVEX:
				node.create_multiple_convex_collisions()
			CollisionType.TRIMESH:
				node.create_trimesh_collision()

	for child in node.get_children():
		if child is StaticBody3D:
			child.queue_free()
		else:
			add_collider(child)
	if node is MeshInstance3D:
		create_collision.call(node)


## Deletes all [StaticBody3D](s) on 'node'.
## This is used by the 'has_colliders' setter function.
func delete_collider(node: Node) -> void:
	for child in node.get_children():
		if child is StaticBody3D:
			child.queue_free()
		else:
			delete_collider(node)


## Exports the tile set data as a [TileSetData] resource using 'export_path' and 'file_name'.
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
