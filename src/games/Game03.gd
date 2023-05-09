extends GameStageDetail

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
#		if Commons.find_str(_tile_kind, GameConstants.Teleport)==0:
		if _tile_kind == GameConstants.Teleport:
			_teleport_tile = true
			return true
	return false

func _change():
	if _button_off: # ボタンオンにする/タイル(15,3)を矢印右へ
		var _pos:Vector2i = player.get_map_position()
		# ボタンオンにする
		_replace_to_button_on(_pos)
		# タイル(14,3)を矢印下へ
		var _altras = GameConstants.Atras_Coords
		var _alternative = GameConstants.Alternative_Tiles
		var _arrow_pos := Vector2i(15,3) 
		var _arrow_down := GameConstants.Arrow_Down
		Commons.set_cell(self,_arrow_pos, GameConstants.Source_Id_Arrows,_altras.get(_arrow_down),_alternative.get(_arrow_down))
		main.play_hit08_1()
	elif _teleport_tile: # テレポートタイルだったら
		# Playerのいる位置のタイルを取得する
		var _curr_pos:Vector2i = player.get_map_position()
		var _curr_tile = Commons.get_tile_data(self,_curr_pos) # 必ず取得できる
		# Playerの位置を、別のテレポートタイルへ移動させる
		var _conditions01 = Callable(self,'_teleport_condition01')
		var _conditions02 = Callable(self,'_teleport_condition02')
		var _action = Callable(self,'_teleport_action')
		action_when_conditions(_conditions01, _conditions02, _action)
		main.play_hit08_1()


# 捜索中タイルがテレポートタイルである条件その１
# プレイヤーの現在位置が捜索中タイルの位置と同じでないとき True
func _teleport_condition01(_pos:Vector2i)->bool:
	var _curr_pos:Vector2i = player.get_map_position()
	if _curr_pos == _pos :
		return false

	return true

# 捜索中タイルがテレポートタイルである条件その２
# 捜索中タイルの種別が 『テレポート』であるとき True
func _teleport_condition02(_pos:Vector2i)->bool:
	var _tile = Commons.get_tile_data(self,_pos)
	if _tile:
		var _kind = Commons.get_tile_data_kind(_tile)
		if Commons.find_str(_kind,GameConstants.Teleport)==0:
			return true

	return false

func _teleport_action(_pos:Vector2i):
	# 見つけたタイルを別のテレポートタイルに置き換える
	var _teleport := GameConstants.Teleport
	var _altras = GameConstants.Atras_Coords
	var _teleport_2 := GameConstants.Teleport_2
	var _alternative = GameConstants.Alternative_Tiles
	Commons.replace_cell(self,_pos,GameConstants.Source_Id_Teleports, _altras.get(_teleport),_alternative.get(_teleport_2))
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
