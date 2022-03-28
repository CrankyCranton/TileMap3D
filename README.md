# TileMap3D
An advanced version of the Godot GridMap node. It supports priority, auto tiling, and automated collision creation.
# How to use
This documentation assumes that you already know the basics of the Godot Game Engine and how to use the GridMap node.

There are four additional nodes in this addon; the TileMap3D, TileSet3D, Tile, and Bitmask3D.
When the word 'update' is used in the property/function descriptions it reffers to applying auto tiling, and priority.
The following will be a more in depth explanation for each node.

# The TileMap3D
Properties:
int map_seed [defalt: 0]:
  The seed used to determine tiles needing priority.

String tile_set [defalt: "res://"]:
  The path to the file containing the tile set data (see line <num> of the documentation)

Array tile_set_data [defalt: []]:
  As the name suggests, it is the variable containing the tile set data.

bool update [defalt: false]:
  When set to any value, it will not retain the value, but instead acts as a trigger to call the function update_map() in the editor.

Functions:
void auto_tile(what: Vector3):
  Updates the tile at what.

Error load_tile_set(tile_set: String = self.tile_set):
  Loads a tile set data file from the path tile_set. If this field is empty, it loads it from self.tile_set. If no errors occur when opening the file, it assigns tile_set to self.tile_set.

void update_map():
  Updates the TileMap3D.

# The TileSet3D

# The Tile

# The Bitmask3D

# Bugs
1. Priority is not very efficient (see TileMap3D.gd line 51).
2. Automatically updating the TileMap3D doesn't work fully (see TileMap3D.gd line 15).
3. And probably many other bugs.
