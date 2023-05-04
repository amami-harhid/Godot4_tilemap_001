extends TileMap

class_name CommonTileMap
#--------------------------
# TileMapを使った操作
#--------------------------
	
func get_tile_data(_pos:Vector2i)->TileData:
	return Commons.get_tile_data(self,_pos)

func get_tile_data_kind(_tiledata:TileData)->String:
	return Commons.get_tile_data_kind(_tiledata)

func replace_cell(_coords:Vector2i, _source_id:int, _atras_coords:Vector2i):
	Commons.replace_cell(self,_coords,_source_id, _atras_coords)

func _set_cell(_coords:Vector2i, _source_id:int, _atras_coords:Vector2i):
	Commons.set_cell(self,_coords,_source_id, _atras_coords)

func _erase_cell(_coords:Vector2i):
	Commons.erase_cell(self,_coords)
	
func get_atras_coords(_key:GameConstants.Atras_Coords_Key) -> Vector2i:
	return GameConstants.Atras_Coords.get(_key)
	
