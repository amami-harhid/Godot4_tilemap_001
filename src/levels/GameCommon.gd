extends TileMap

#===================================
# GameNN.gd の親クラス
#===================================

class_name GameCommon

@onready var canvasLayerTilemap:CanvasLayerTileMapCommon = get_node('../../../CanvasLayerTileMap')
@onready var player:Sprite2D = get_node('../../../CanvasLayerPlayer/PlayerSprite2D')

# Playerの初期処理
func _player_initialize():
	player.set_map_position(_get_init_position())
	# Playerが持つ位置情報の位置へと移動する
	player.start_animation(_get_animation_wait_time())
	# Playerが持つ位置情報の位置へと移動する
	_move()

# 継承先でオーバーライドすること
# Playerの初期位置
func _get_init_position()->Vector2i:
	return Vector2i(-1,-1)
	
# 継承先でオーバーライドすること
# Playerのアニメーション間隔（秒）
func _get_animation_wait_time()->float:
	return 10

# Playerを操作するメソッド
# GameSceneのTileMap(=game)の_process() で呼び出すこと
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
		pass

	# ゲームレベルクリア条件を満たしたか？	
	# -- ゲームレベルクリア条件は、継承先で変更できる	
	if _is_game_clear():
		canvasLayerTilemap.level_up()
		canvasLayerTilemap.load_game()
	else:
		# テレポートをさせるタイルの上にプレイヤーがいるか？
		if _is_teleportation_tile():
			# テレポートの条件、テレポートの内容は継承先で定義する
			_teleport()

		# 他のタイルの変更を起こすタイルの上にプレイヤーがいるか？
		if _is_changing_tile():
			# ゲームに応じて変化をさせる
			# 変化起因の条件、変化の内容は継承先で定義する
			_change()


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
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata :
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Door:
			# ドアに入った
			return true

	return false

# 必要に応じて継承先でオーバーライドすること
# 他のタイルの変更を起こすタイルの上にプレイヤーがいるとき Trueを返す
func _is_changing_tile()->bool:
	# デフォルトはfalse
	return false

# 必要に応じて継承先でオーバーライドすること
func _change():
	# デフォルトは何もしない
	pass

# 必要に応じて継承先でオーバーライドすること
# Playerがテレポートをする種類のタイルにいるとき Trueを返す
func _is_teleportation_tile()->bool:
	# デフォルトはfalse
	return false

# 継承先でオーバーライドすること
# Playerにテレポートをさせる
func _teleport():
	# デフォルトは何もしない
	pass
