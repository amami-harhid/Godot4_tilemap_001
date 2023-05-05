extends GameCommon

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
	var _meta = player.get_map_position()
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
	var _pos:Vector2i = player.get_map_position()
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata:
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if Commons.find_str(_tile_kind, GameConstants.Lever_Off)==0:
			_lever_off = true
			return true
	return false

func _change():
	if _lever_off:
		var _pos:Vector2i = player.get_map_position()
		var _lever_on := GameConstants.Lever_On
		var _altras = GameConstants.Atras_Coords
		Commons.replace_cell(self, _pos, GameConstants.Source_Id_Levers, _altras.get(_lever_on))
		var _door_pos := Vector2i(1,1)
		var _door := GameConstants.Door
		Commons.set_cell(self,_door_pos, GameConstants.Source_Id_Door, _altras.get(_door))
	pass
# Playerがいるタイルは抜け出せるか
func _can_escape_from_current_tile(_pos:Vector2i)->bool:
	return true

# Playerは次の位置のタイルへ入れるか
func _can_enter_to_next_position(_next_pos:Vector2i)->bool:
	# 次の位置のタイルを取得する
	var _tiledata:TileData = Commons.get_tile_data(self,_next_pos)
	if _tiledata :
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Wall:
			# 『壁』には入れない。
			return false

	return true
