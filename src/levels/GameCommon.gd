extends CommonTileMap

class_name GameCommon

@onready var canvasLayerTilemap:CanvasLayerTileMapCommon = get_node('../../../CanvasLayerTileMap')
@onready var player:Sprite2D = get_node('../../../CanvasLayerPlayer/PlayerSprite2D')

func _process_player():
	if Input.is_action_just_pressed("ui_up"):
		_move_up()
		player.animation_up()
	elif Input.is_action_just_pressed("ui_right"):
		_move_right()
		player.animation_right()
	elif Input.is_action_just_pressed("ui_left"):
		_move_left()
		player.animation_left()
	elif Input.is_action_just_pressed("ui_down"):
		_move_down()
		player.animation_down()
	else:
		_move()

	if _is_game_clear():
		canvasLayerTilemap.level_up()
		canvasLayerTilemap.load_game()

	if _is_change():
		_change()

	if _is_teleport():
		_teleport()


# 右に進めるなら右に進む
func _move_right():
	if _can_move(GameConstants.Dir_Right):
		_move(GameConstants.Dir_Right)

# 左に進めるなら左に進む
func _move_left():
	if _can_move(GameConstants.Dir_Left):
		_move(GameConstants.Dir_Left)

# 上に進めるなら上に進む
func _move_up():
	if _can_move(GameConstants.Dir_Up):
		_move(GameConstants.Dir_Up)

# 下に進めるなら下に進む
func _move_down():
	if _can_move(GameConstants.Dir_Down):
		_move(GameConstants.Dir_Down)

# 指定した向きに動く
func _move(_dir:Vector2i = Vector2i(0,0)):
	var _meta = player.get_map_position()
	if _meta :
		var _map_pos:Vector2i = _meta
		var _next_map_pos:Vector2i = _map_pos + _dir
		var _local_pos = self.map_to_local(_next_map_pos)
		player.position = _local_pos
		player.set_meta(GameConstants.Map_Position_Key, _next_map_pos)

# 継承先でオーバーライドすること
func _can_move(_dir:Vector2i)->bool:
	print('継承先でオーバーライドすること')	
	return false

# レベルクリア条件
# 『ドア』に入ったらレベルクリア！
# 必要に応じて継承先でオーバーライドすること
func _is_game_clear():
	# 「ドアに入った」判定を１回だけ行うため
	# タイルマップが表示されているときだけ
	# ゲームクリア判定をする
	if not canvasLayerTilemap.visible :
		return false
	# 現在位置のタイルを取得する
	var _pos:Vector2i = player.get_map_position()
	var _tiledata:TileData = get_tile_data(_pos)
	if _tiledata :
		var _tile_kind:String = get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Door:
			# ドアに入った
			return true

	return false

func _is_change()->bool:
	return false

func _change():
	pass

# 継承先でオーバーライドすること
func _is_teleport()->bool:
	return false

# 継承先でオーバーライドすること
func _teleport():
	pass
