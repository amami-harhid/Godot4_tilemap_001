extends MainDetail

# Gameのスクリプト(GameCommon)の中で Mainとして使いたいため
# クラス名をつけている
class_name Main

var _game_sounds:GameSounds

func _ready():
	level_up()
	load_game()
	_sound_load()
	_play_musmus_BGM_090()

func _sound_load():
	_game_sounds = GameSounds.new()
	_game_sounds.sound_load(self)

func _play_musmus_BGM_090():
	_game_sounds.play_musmus_BGM_090(2)

func _play_hit08_1():
	_game_sounds.play_hit08_1()


func _process(delta):
	pass


var _mouse_move = false

# GUI Panel 
func _on_touch_panel_gui_input(event:InputEvent):
	if event.button_mask > 0:
		var _relative = event.get('relative')
		if _relative :
			_mouse_move = true
			if abs(_relative.x) > abs(_relative.y):
				# 横方向の移動とする
				if _relative.x > 0:
					print('右へ')
				elif _relative.x < 0:
					print('左へ')
			else:
				# 縦方向の移動とする
				if _relative.y > 0:
					print('下へ')
				elif _relative.y < 0:
					print('上へ')
				pass
			print(event.relative)
		pass
	else:
		_mouse_move = false
	pass # Replace with function body.
