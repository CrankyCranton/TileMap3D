# TileMap3D
An advanced version of the Godot GridMap node. It supports priority, auto tiling, and automated collision creation.
# How to use
This documentation assumes that you already know the basics of the Godot Game Engine and how to use the GridMap node.

There are four additional nodes in this addon; the TileMap3D, TileSet3D, Tile, and Bitmask3D.
The following will be a more in depth explanation for each node.

Terminology:

'update':
This reffers to applying auto tiling, and priority.

'tile set data':
This means data containing both auto tiling and priority.


# The TileMap3D
Properties:

int map_seed [defalt: 0]:
  The seed used to determine tiles needing priority. Tiles only need priority when there are multiple different tiles that have a bitmask that fit a particular location.

String tile_set [defalt: "res://"]:
  The path to the file containing the tile set data (see line 61 of the documentation).

Array tile_set_data [defalt: []]:
  As the name suggests, it is the variable containing the tile set data.

bool _update [defalt: false]:
  When set to any value, it will not retain the value, but instead acts as a trigger to call the function update_map() in the editor.

Functions:

void auto_tile(what: Vector3):
  Updates the tile at what.

Error load_tile_set(tile_set: String = self.tile_set):
  Loads a tile set data file from the path tile_set. If this field is empty, it loads it from self.tile_set. If no errors occur when opening the file, it assigns tile_set to self.tile_set.

void update_map():
  Updates the TileMap3D.

# The TileSet3D
Properties:

bool convex_collisions [defalt: false]:
  Used to determine whether to use convex collisions or trimesh collisions when has_colliders is set to true.

bool export [defalt: false]:
  Like the TileMap3D's property _update (see line 21 of the documetation), this acts as a in-editor trigger to call the function export_tile_set_data().

String export_path [defalt: "res://"]:
  The file path to export to when export_tile_set_data() is called. It is important for this value to always end with a foward slash.

String file_name [defalt: ""]:
  The file name used when export_tile_set_data() is called.

bool has_colliders [defalt: false]:
  When set to true, it will automaticly generate colliders for the tiles. Likewise when set to false, it will automaticly delete all the colliders on the tiles.

float space [defalt: 0.0]:
  When set, it automaticly positions the tiles in a line with spacing between the tiles equal to the variables value as to see them better.

Functions:

void add_collider(to: MeshInstance):
  Removes all colliders and then adds a collider to the tile to.

void delete_collider(of: MeshInstance):
  Removes all colliders on the tile of.

void export_tile_set_data():
  Exports the tile set data.

Array get_tile_set_data():
  Returns an array containing the tile set data.

# The Tile
If you are adding in tiles by draging the files from the fileSystem editor into the scene, Godot will automaticly make the tiles MeshInstances. To make them the Tile class, you can simply select all the tiles and drag in the Tile.gd file onto the script property in the inspector.

Properties:

PackedScene replace_with [defalt: null]:
  If not null, it will replace any tile of this type with the value unpacked (as a scene).

Functions:

Dictionary get_data():
  Returns a Dictionary containing the tile data.

# The Bitmask3D

# Bugs
1. Priority is not very efficient (see TileMap3D.gd line 51).
2. Automatically updating the TileMap3D doesn't work fully (see TileMap3D.gd line 15).
3. And probably many other bugs.
