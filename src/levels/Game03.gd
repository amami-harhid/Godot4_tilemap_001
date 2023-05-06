extends GameCommon

#----------------------
# Level03
#----------------------
# TileMapへPlayerを配置するのは
# GameSceneのadd_child()をしたときがふさわしい。
const Player_Init_Position := Vector2i(16,8)

func _ready():
	_player_initialize()

# プレイヤーの初期位置を返す
func _get_init_position()->Vector2i:
	return Player_Init_Position

func _get_animation_wait_time()->float:
	return 0.2

func _process(delta):
	_process_player()

var _button_off    := false
var _teleport_tile := false
# 変化させるタイルの条件
func _is_changing_tile()->bool:
	_button_off = false
	_teleport_tile = false
	var _pos:Vector2i = player.get_map_position()
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata:
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if Commons.find_str(_tile_kind, GameConstants.Button_Off)==0:
			_button_off = true
			return true
		if not _teleport_tile:
			if Commons.find_str(_tile_kind, GameConstants.Teleport)==0:
				_teleport_tile = true
				return true
	return false

func _change():
	if _button_off: # ボタンオンにする/タイル(14,3)を矢印右へ
		var _pos:Vector2i = player.get_map_position()
		var _lever_on := GameConstants.Button_On
		var _altras = GameConstants.Atras_Coords
		Commons.replace_cell(self, _pos, GameConstants.Source_Id_Buttons, _altras.get(_lever_on))
		var _arrow_down_pos := Vector2i(14,3) 
		var _arrow_down := GameConstants.Arrow_Down
		Commons.set_cell(self,_arrow_down_pos, GameConstants.Source_Id_Arrows,_altras.get(_arrow_down))
	elif _teleport_tile: # テレポートタイルだったら
		# Playerのいる位置のタイルを取得する
		var _curr_pos:Vector2i = player.get_map_position()
		var _curr_tile = Commons.get_tile_data(self,_curr_pos) # 必ず取得できる
		# Playerの位置を、別のテレポートタイルへ移動させる
		var _rect:Rect2i = self.get_used_rect()
		for _y in range(_rect.size.y):
			for _x in range(_rect.size.x):
				var _pos := Vector2i(_x,_y)
				var _tile = Commons.get_tile_data(self,_pos)
				if _tile:
					var _kind = Commons.get_tile_data_kind(_tile)
					if Commons.find_str(_kind,GameConstants.Teleport)==0:
						if _tile != _curr_tile:
							# 見つけたタイルの位置へ
							player.set_map_position(_pos)
							self._move()

# Playerが動ける条件を記載する
func _can_move(_dir:Vector2i)->bool:
	var _meta = player.get_map_position()
	if _meta:
		var _current_pos:Vector2i = _meta
		if _can_escape_from_current_tile(_dir):
			var _next_pos:Vector2i = _current_pos + _dir
			if _can_enter_to_next_position(_next_pos):
				return true
	return false

# Playerがいるタイルは抜け出せるか
func _can_escape_from_current_tile(_dir:Vector2i)->bool:
	var _meta = player.get_map_position()
	if _meta:
		var _current_pos:Vector2i = _meta
		var _tiledata:TileData = Commons.get_tile_data(self,_current_pos)
		if _tiledata :
			var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
			# 矢印タイルのとき向きが一致すれば Trueを返す
			if _tile_kind == GameConstants.Arrow_Left:
				return _dir == GameConstants.Dir_Left
			elif _tile_kind == GameConstants.Arrow_Right:
				return _dir == GameConstants.Dir_Right
			elif _tile_kind == GameConstants.Arrow_Up:
				return _dir == GameConstants.Dir_Up
			elif _tile_kind == GameConstants.Arrow_Down:
				return _dir == GameConstants.Dir_Down
			else:
				# タイル種別が該当なしのとき
				return true
		else:
			return true
	return false

# Playerは次の位置のタイルへ入れるか
func _can_enter_to_next_position(_next_pos:Vector2i)->bool:
	# 次の位置のタイルを取得する
	var _tiledata:TileData = Commons.get_tile_data(self,_next_pos)
	if _tiledata :
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Wall:
			return false

	return true
