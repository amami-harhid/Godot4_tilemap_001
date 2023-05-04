extends GameCommon

#----------------------
# Level03
#----------------------
# TileMapへPlayerを配置するのは
# GameSceneのadd_child()をしたときがふさわしい。
const Player_Init_Position := Vector2i(1,1)

func _ready():
	player.set_map_position(Player_Init_Position)
	player.start_animation(0.2)

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

# Playerがいるタイルは抜け出せるか
func _can_escape_from_current_tile(_pos:Vector2i)->bool:
	return true

# Playerは次の位置のタイルへ入れるか
func _can_enter_to_next_position(_next_pos:Vector2i)->bool:
	# 次の位置のタイルを取得する
	var _tiledata:TileData = get_tile_data(_next_pos)
	if _tiledata :
		var _tile_kind:String = get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Wall:
			return false

	return true
