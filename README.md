# TileMap3D
An advanced version of the Godot GridMap node. It supports priority, auto tiling, and automated collision creation.
# How to use
This documentation assumes that you already know the basics of the Godot Game Engine and how to use the GridMap node.

There are four additional nodes in this addon; the TileMap3D, TileSet3D, Tile, and Bitmask3D.
The following will be a more in depth explanation for each node.

# The TileMap3D
Properties:
  int map_seed [defalt: 0]:
    The seed used to determine tiles needing priority.
  String tile_set [defalt: "res://"]:
    The path to the file containing the tile set data (see line <num> of the documentation)
  bool update [defalt: false]:
    When set to any value, it will not retain the value, but instead acts as a trigger to call the function update_map() in the editor.
  
Functions:
  void auto_tile(what: Vector3):
    Applies auto tiling to the tile at what.
  int load_tile_set(tile_set: String)
    
  void update_map():
    
  
# The TileSet3D

# The Tile

# The Bitmask3D

# Bugs
1. Priority is not very efficient (see TileMap3D.gd line 51).
2. Automatically updating the TileMap3D doesn't work fully (see TileMap3D.gd line 15).
3. And probably many other bugs.
