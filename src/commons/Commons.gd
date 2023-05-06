extends Node

#===============================================
# Commons.gd
#===============================================
# いろんなところで使いそうな便利メソッドをここにまとめる
#-----------------------------------------------

# 指定した秒数分スリープしたあとに与えたメソッドを実行する
func wait_and_call(_sec:float, _obj: Object, _method_name:String):
	var _method:Callable = Callable(_obj, _method_name)
	one_shot_timer(_sec,_method)
	
# 指定した秒数分スリープしたあとに与えたメソッドを実行する
func one_shot_timer(_sec: float, _method: Callable):
	if _sec > 0 :
		var _timer:Timer = Timer.new()
		add_child(_timer)
		_timer.wait_time = _sec
		_timer.one_shot = true
		_timer.start()
		await _timer.timeout # 指定した時間経過するまで停止する
		_timer.queue_free() # タイマーを消す
	_method.call()

# val1に含まれる val2の位置を返す
# 先頭の場合 0
# 含まれない場合は -1 
# ※ 返却値 == 0 のときは 先頭にVal2がある
func find_str(val1:String, val2:String)->int:
	if val1 == null || val2 == null:
		return -1
	return val1.find(val2,0)

# タイルマップの指定したマップ位置にあるタイルデータを返す
# タイルマップのレイヤーは 固定とする
# レイヤーを１枚だけ用意する前提のメソッドである
func get_tile_data(_tilemap:TileMap,_pos:Vector2i)->TileData:
	return _tilemap.get_cell_tile_data(GameConstants.Layer_Tile_Data, _pos)

# タイルデータのカスタムデータを返す
# カスタムデータは１個だけの前提のメソッドである
func get_tile_data_kind(_tiledata:TileData)->String:
	return _tiledata.get_custom_data_by_layer_id(GameConstants.Layer_Data_Kind)

# 使われているタイルをすべて取り出し配列として返す
# カスタムデータは１個だけの前提のメソッドである
func get_used_cells(_tileMap:TileMap)->Array:
	return _tileMap.get_used_cells(GameConstants.Layer_Tile_Data)

# 指定したマップ位置のタイルを別のタイルへ変更する
# タイルマップのレイヤーは 固定とする
# レイヤーを１枚だけ用意する前提のメソッドである
# _source_id は、GameConstants に記載あり。
# _atras_coords は、GameConstants に記載あり。
func replace_cell(_tilemap:TileMap,_coords:Vector2i, _source_id:int, _atras_coords:Vector2i,_alternative_coords:int=0):
	erase_cell(_tilemap,_coords)
	set_cell(_tilemap,_coords, _source_id, _atras_coords,_alternative_coords)

# 指定した位置のタイルを消去する
# タイルマップのレイヤーは 固定とする
# レイヤーを１枚だけ用意する前提のメソッドである
func erase_cell(_tilemap:TileMap,_coords:Vector2i):
	_tilemap.erase_cell(GameConstants.Layer_Tile_Data, _coords)

# 指定したマップ位置へタイルを設定する
# タイルマップのレイヤーは 固定とする
# レイヤーを１枚だけ用意する前提のメソッドである
# _source_id は、GameConstants に記載あり。
# _atras_coords は、GameConstants に記載あり。
func set_cell(_tilemap:TileMap,_coords:Vector2i, _source_id:int, _atras_coords:Vector2i,_alternative_coords:int=0):
	#_tilemap.set_cell(GameConstants.Layer_Tile_Data, _coords, _source_id, _atras_coords)
	_tilemap.set_cell(GameConstants.Layer_Tile_Data, _coords, _source_id, _atras_coords,_alternative_coords)

