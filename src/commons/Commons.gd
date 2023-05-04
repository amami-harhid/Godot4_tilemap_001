extends Node

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

# val1に含まれる val2の位置
# 先頭の場合 0
# 含まれない場合は -1
func find_str(val1:String, val2:String)->int:
	if val1 == null || val2 == null:
		return -1
	return val1.find(val2,0)

func get_tile_data(_tilemap:TileMap,_pos:Vector2i)->TileData:
	return _tilemap.get_cell_tile_data(GameConstants.Layer_Tile_Data, _pos)

func get_tile_data_kind(_tiledata:TileData)->String:
	return _tiledata.get_custom_data_by_layer_id(GameConstants.Layer_Data_Kind)

func replace_cell(_tilemap:TileMap,_coords:Vector2i, _source_id:int, _atras_coords:Vector2i):
	erase_cell(_tilemap,_coords)
	set_cell(_tilemap,_coords, _source_id, _atras_coords)

func set_cell(_tilemap:TileMap,_coords:Vector2i, _source_id:int, _atras_coords:Vector2i):
	_tilemap.set_cell(GameConstants.Layer_Tile_Data, _coords, _source_id, _atras_coords)

func erase_cell(_tilemap:TileMap,_coords:Vector2i):
	_tilemap.erase_cell(GameConstants.Layer_Tile_Data, _coords)
	
