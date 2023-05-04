extends Sprite2D

class_name BasePlayerSprite2D

func set_map_position(_pos:Vector2i):
	self.set_meta(GameConstants.Map_Position_Key, _pos)

func get_map_position()->Vector2i:
	return self.get_meta(GameConstants.Map_Position_Key)

func animation_up():
	self.frame_coords.y = GameConstants.Frame_Up
func animation_right():
	self.frame_coords.y = GameConstants.Frame_Right
func animation_left():
	self.frame_coords.y = GameConstants.Frame_Left
func animation_down():
	self.frame_coords.y = GameConstants.Frame_Down
func next_h_frame():
	var _x = (self.frame_coords.x + 1) % self.hframes
	self.frame_coords.x = _x

var _timer:Timer = Timer.new()
func start_animation(_wait_time:float):
	_loop_timer_start(_wait_time, _next_frame_callable())

func _next_frame_callable()->Callable:
	var _callable = Callable(self,'next_h_frame')
	return _callable
	
func _loop_timer_start(_wait_time:float, _callable:Callable):
	# タイマー動作中のときは何もしない
	if _timer.is_stopped():
		_timer.wait_time = _wait_time
		_timer.one_shot = false
		_timer.connect('timeout',_callable)
		add_child(_timer)
		_timer.start()
