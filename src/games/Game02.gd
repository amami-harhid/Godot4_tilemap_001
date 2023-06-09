extends GameStageDetail

#----------------------
# Level02
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

var _lever_off_A := false
var _lever_off_B := false
# 変化させるタイルの条件
func _is_changing_tile()->bool:
	_lever_off_A = false
	_lever_off_B = false
	var _pos:Vector2i = player.get_map_position(self)
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata:
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if Commons.find_str(_tile_kind, GameConstants.Lever_Off_a)==0:
			_lever_off_A = true
			return true
		if Commons.find_str(_tile_kind, GameConstants.Lever_Off_b)==0:
			_lever_off_B = true
			return true
	return false

func _change():
	if _lever_off_A: # 1回目のレバーオンで 2番目のレバー出現(AlternativeTile)
		var _pos:Vector2i = player.get_map_position(self)
		var _lever_on := GameConstants.Lever_On
		var _altras = GameConstants.Atras_Coords
		Commons.replace_cell(self, _pos, GameConstants.Source_Id_Levers, _altras.get(_lever_on))
		var _lever_off_b_pos := Vector2i(4,6) # 2番目のレバーOFF出現の位置
		var _lever_off := GameConstants.Lever_Off
		var _lever_off_b := GameConstants.Lever_Off_b
		var _alternative = GameConstants.Alternative_Tiles
		Commons.set_cell(self,_lever_off_b_pos, GameConstants.Source_Id_Levers,_altras.get(_lever_off),_alternative.get(_lever_off_b))
		main.play_hit08_1()
	elif _lever_off_B: # ２回目のレバーオンでドア出現
		# レバーオンにする
		var _pos:Vector2i = player.get_map_position(self)
		_replace_to_lever_on(_pos)
		# 『ドア』タイルを出現させる
		var _door_pos := Vector2i(1,1)
		_add_door_tile(_door_pos)
		main.play_hit08_1()
	pass

# Playerが動ける条件を記載する
func _can_move(_dir:Vector2i)->bool:
	var _meta = player.get_map_position(self)
	if _meta:
		var _current_pos:Vector2i = _meta
		if _can_escape_from_current_tile(_dir):
			var _next_pos:Vector2i = _current_pos + _dir
			if _can_enter_to_next_position(_next_pos):
				return true
	return false

# Playerがいるタイルは抜け出せるか
func _can_escape_from_current_tile(_dir:Vector2i)->bool:
	var _escape:bool = _match_arrows_direction(_dir)
	return _escape

# Playerは次の位置のタイルへ入れるか
func _can_enter_to_next_position(_next_pos:Vector2i)->bool:
	# 次の位置のタイルを取得する
	var _tiledata:TileData = Commons.get_tile_data(self,_next_pos)
	if _is_wall_tile(_tiledata): # 『壁』タイルのとき
		# 入れない
		return false

	# 入れる
	return true
