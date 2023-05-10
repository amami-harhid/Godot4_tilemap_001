extends GameStageDetail

#----------------------
# Level01
#----------------------
# TileMapへPlayerを配置するのは
# GameSceneのadd_child()をしたときがふさわしい。
const Player_Init_Position := Vector2i(1,1)

func _ready():
	_player_initialize()

# プレイヤーの初期位置を返す
func _get_init_position()->Vector2i:
	return Player_Init_Position

func _get_animation_wait_time()->float:
	return 0.2
	
func _process(delta):
	_process_player()

# Playerが動ける条件を記載する
func _can_move(_dir:Vector2i)->bool:
	var _meta = player.get_map_position(self)
	if _meta:
		var _current_pos:Vector2i = _meta
		if _can_escape_from_current_tile(_current_pos):
			var _next_pos:Vector2i = _current_pos + _dir
			if _can_enter_to_next_position(_next_pos):
				return true
	return false

var _lever_off := false
# 変化させるタイルの条件
func _is_changing_tile()->bool:
	_lever_off = false
	var _pos:Vector2i = player.get_map_position(self)
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata:
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if Commons.find_str(_tile_kind, GameConstants.Lever_Off)==0:
			print(_tile_kind, GameConstants.Lever_Off)
			_lever_off = true
			return true
	return false

func _change():
	# 何が変化するのかをフラグで判断する
	if _lever_off:
		print('_change')
		# レバーオンにする
		var _pos:Vector2i = player.get_map_position(self)
		_replace_to_lever_on(_pos)
		# 『ドア』タイルを出現させる
		var _door_pos := Vector2i(1,1)
		_add_door_tile(_door_pos)
	pass

# Playerがいるタイルは抜け出せるか
func _can_escape_from_current_tile(_pos:Vector2i)->bool:
	return true

# Playerは次の位置のタイルへ入れるか
func _can_enter_to_next_position(_next_pos:Vector2i)->bool:
	# 次の位置のタイルを取得する
	var _tiledata:TileData = Commons.get_tile_data(self,_next_pos)
	if _is_wall_tile(_tiledata): # 『壁』タイルのとき
		# 入れない
		return false

	# 入れる
	return true
	
