extends TileMap

#===================================
# GameStageDetail/GameNN.gd の親クラス
#===================================

class_name GameCommon

# Mainノード
@onready var main:Main = self.get_tree().root.get_node('Main') 
# ゲームタイルマップノード
@onready var canvasLayerTilemap:CanvasLayer = main.get_node('CanvasLayerTileMap')
# プレイヤーノード
@onready var player:Player = main.get_node('CanvasLayerPlayer/PlayerSprite2D')

var point_light:PointLight2D;

func _point_light_init():
	point_light = get_node('PointLight2D')

# Playerの初期処理
func _player_initialize():
	player.set_map_position(self,_get_init_position())
	# Playerが持つ位置情報の位置へと移動する
	player.start_animation(_get_animation_wait_time())

# 継承先でオーバーライドすること
# Playerの初期位置
func _get_init_position()->Vector2i:
	return Vector2i(-1,-1)
	
# 継承先でオーバーライドすること
# Playerのアニメーション間隔（秒）
func _get_animation_wait_time()->float:
	return 10 # 仮の値

# Playerのローカル座標(Position)をマップ座標に変換して返す
func _get_map_position(_player:Player)->Vector2i:
	return local_to_map(_player.position)

# Playerを操作するメソッド
# GameSceneのTileMap(=game)の_process() で呼び出すこと
func _process_player():
	# 『mouse_flick』: インプットマップへ登録したアクション
	# 左クリックされたときのアクションとして登録
	# タッチスクリーンでタッチしたときも反応する
	if Input.is_action_just_released("mouse_flick"):
		# 左クリック（またはタッチ）されたとき、マウス位置(タッチ位置）を取得する
		var _mouse_pos = get_viewport().get_mouse_position()
		# マウス位置をマップ座標へ変換、Playerのマップ位置との差を求める
		var _pos = local_to_map(_mouse_pos)  - _get_map_position(player)
		# マップ座標差分の絶対値をとる
		var _abs_pos = abs(_pos)
		# 左右方向(x) の差分と上下方向(y) の差分を比較
		if _abs_pos.x > _abs_pos.y :
			# 左右方向(x) の差分が大きいときは上下方向差分を無視
			if _pos.x > 0: # Playerの右側でクリックしたとき
				_move_right()
				player.animation_right()
			elif _pos.x < 0: # Playerの左側でクリックしたとき
				_move_left()
				player.animation_left()
		else:
			# 上下方向(y) の差分が大きいときは左右方向差分を無視
			if _pos.y > 0: # Playerの下側でクリックしたとき
				_move_down()
				player.animation_down()
			elif _pos.y < 0: # Playerの上側でクリックしたとき
				_move_up()
				player.animation_up()
	
	# キー(右)が押されたとき
	elif Input.is_action_just_pressed("ui_right"):
		_move_right() # 右へ
		player.animation_right()
	# キー(左)が押されたとき
	elif Input.is_action_just_pressed("ui_left"):
		_move_left() # 左へ
		player.animation_left()
	# キー(下)が押されたとき
	elif Input.is_action_just_pressed("ui_down"):
		_move_down() # 下へ
		player.animation_down()
	# キー(上)が押されたとき
	elif Input.is_action_just_pressed("ui_up"):
		_move_up() # 上へ
		player.animation_up()
	else:
		# 何もしない
		pass
	
	# ゲームレベルクリア条件を満たしたか？	
	# -- ゲームレベルクリア条件は、継承先で変更できる	
	if _is_stage_clear():
		# ステージレベルアップ
		main.level_up()
		# 新しいステージをロードする（古いステージは消す）
		main.load_game()
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
		# Playerがいる現在のタイルから右へ移動できるとき
		_move(GameConstants.Dir_Right)

# 左に進めるなら左に進む
func _move_left():
	if _can_move(GameConstants.Dir_Left):
		# Playerがいる現在のタイルから左へ移動できるとき
		_move(GameConstants.Dir_Left)

# 上に進めるなら上に進む
func _move_up():
	if _can_move(GameConstants.Dir_Up):
		# Playerがいる現在のタイルから上へ移動できるとき
		_move(GameConstants.Dir_Up)

# 下に進めるなら下に進む
func _move_down():
	if _can_move(GameConstants.Dir_Down):
		# Playerがいる現在のタイルから下へ移動できるとき
		_move(GameConstants.Dir_Down)

# 指定した向きに動く
func _move(_dir:Vector2i = Vector2i(0,0)):
	# Playerの現在位置(Map座標)を取り出す
	var _map_pos:Vector2i = _get_map_position(player)
	#var _map_pos:Vector2i = player.get_map_position()
	# Playerの次のタイルの位置(Map座標)を計算する
	var _next_map_pos:Vector2i = _map_pos + _dir
	# 次タイルの位置(Map座標)をローカル座標にして、
	# PlayerのPositionへ設定(Playerの位置変更)
	var _local_pos = self.map_to_local(_next_map_pos)
	player.position = _local_pos
	#player.set_map_position(_next_map_pos)
	if point_light:
		point_light.position = player.position
	if( not _dir == Vector2i(0,0)):
		main.play_shutter_01_1()

# 継承先でオーバーライドすること
func _can_move(_dir:Vector2i)->bool:
	print('継承先でオーバーライドすること')	
	return false

# レベルクリア条件
# 『ドア』に入ったらレベルクリア！
# 必要に応じて継承先でオーバーライドすること
func _is_stage_clear():
	# 「ドアに入った」判定を１回だけ行うため
	# タイルマップが表示されているときだけ
	# ゲームクリア判定をする
	if not canvasLayerTilemap.visible :
		return false
	# 現在位置のタイルを取得する
	#var _pos:Vector2i = player.get_map_position()
	var _pos:Vector2i = _get_map_position(player)
	var _tiledata:TileData = Commons.get_tile_data(self,_pos)
	if _tiledata :
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		if _tile_kind == GameConstants.Door:
			# ドアに入った
			main.play_hit08_1()
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
