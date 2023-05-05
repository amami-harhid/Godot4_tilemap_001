extends Node

#----------------------------------------------
# TilemapPlayer.gd
#
# TileMapとPlayerを使った操作をここにまとめる
#----------------------------------------------

# Playerが指定した方向へ進めるか
func can_move(_tilemap:TileMap,_player:Sprite2D,_dir:Vector2i)->bool:
	if _tilemap:
		if can_escape_tile(_tilemap,_player,_dir):
			return can_move_to_next_position(_tilemap,_player,_dir)
		else:
			return false
	else:
		return false

# Playerがタイルを抜け出せるか	
func can_escape_tile(_tilemap:TileMap,_player:Sprite2D,_dir:Vector2i)->bool:
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	var _tile_data:TileData = Commons.get_tile_data(_tilemap, _current_position)
	if _tile_data :
		# 現在地にタイルがあるとき
		var _kind:String = Commons.get_tile_data_kind(_tile_data)
		if _kind :
			if Commons.find_str(_kind, GameConstants.Arrow) == 0:
				# 矢印の向きと進行方向が同じときには『進める』
				if _kind == GameConstants.Arrow_Right && _dir == GameConstants.Dir_Right:
					_movable = true
				elif _kind == GameConstants.Arrow_Left && _dir == GameConstants.Dir_Left:
					_movable = true
				elif _kind == GameConstants.Arrow_Up && _dir == GameConstants.Dir_Up:
					_movable = true
				elif _kind == GameConstants.Arrow_Down && _dir == GameConstants.Dir_Down:
					_movable = true
			else:
				# 現在地のタイルが『矢印』でないとき
				# 『進める』
				_movable = true
		else:
			# 現在地のタイルにタイル種別がないとき
			# 『進める』
			_movable = true
	else:
		# 現在地にタイルがないとき
		# 『進める』
		_movable = true

	return _movable

# 次の位置のタイルは進めるタイルなのか
func can_move_to_next_position(_tilemap:TileMap,_player:Sprite2D,_dir:Vector2i)->bool:
	var _movable := false
	# Playerの現在地( map位置 )
	var _current_position:Vector2i = _tilemap.local_to_map(_player.position)
	# Playerの次の位置( map位置 )
	var _next_position:Vector2i = _current_position
	_next_position += _dir
	
	# 次の位置にあるタイルを取り出す
	var _tile_data:TileData = Commons.get_tile_data(_tilemap, _next_position)
	if _tile_data:
		# 次の位置にタイルがあるとき
		var _kind:String = Commons.get_tile_data_kind(_tile_data)
		if _kind:
			if _kind == GameConstants.Wall:
				# 次の位置が『壁』のとき
				# 『進めない』
				_movable = false
			else:
				# 次の位置が『壁』でないとき
				# 『進める』
				_movable = true
		else:
			# 次の位置のタイルにタイル種別がないとき
			# 『進める』
			_movable = true
	else:
		# 次の位置にタイルがないとき
		# 『進める』
		_movable = true
	return _movable
