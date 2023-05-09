extends Sprite2D

#===================================
# PlayerSprte2D.gd の親クラス
#===================================

#-----------------------------------------------
# PlayerSprite2D側では直接には下記メソッドたちを
# 利用しない。
# GameNN のスクリプトの中（及びGameNNの親クラス）の
# 中で利用している。
#-----------------------------------------------

class_name BasePlayerSprite2D

# プレイヤーのマップ位置
var _map_position = Vector2i(-1,-1)

# プレイヤーのマップ位置を設定する
func set_map_position(_pos:Vector2i):
	_map_position = _pos

# プレイヤーのマップ位置を返す
func get_map_position()->Vector2i:
	return _map_position

# アニメーション（縦）を上向きにする
func animation_up():
	self.frame_coords.y = GameConstants.Frame_Up
# アニメーション（縦）を右向きにする
func animation_right():
	self.frame_coords.y = GameConstants.Frame_Right
# アニメーション（縦）を左向きにする
func animation_left():
	self.frame_coords.y = GameConstants.Frame_Left
# アニメーション（縦）を下向きにする
func animation_down():
	self.frame_coords.y = GameConstants.Frame_Down
# アニメーション（横）を変える
func next_h_frame():
	var _x = (self.frame_coords.x + 1) % self.hframes
	self.frame_coords.x = _x

# タイマー
var _timer:Timer = Timer.new()
# 与えた秒数間隔のタイマーを開始する。
func start_animation(_wait_time:float):
	_loop_timer_start(_wait_time, _next_frame_callable())

# タイマーのタイムアウト時に実行する処理をCallableにして返す
func _next_frame_callable()->Callable:
	var _callable = Callable(self,'next_h_frame')
	return _callable
	
# タイマーをスタートして、タイムアウト時に与えたCallableの処理を実行する
func _loop_timer_start(_wait_time:float, _callable:Callable):
	# タイマー動作中のときは何もしない
	if _timer.is_stopped():
		_timer.wait_time = _wait_time
		_timer.one_shot = false
		_timer.connect('timeout',_callable)
		add_child(_timer)
		_timer.start()
