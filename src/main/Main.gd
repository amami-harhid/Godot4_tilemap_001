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
