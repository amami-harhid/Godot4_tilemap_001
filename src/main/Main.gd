extends MainDetail

# Gameのスクリプト(GameCommon)の中で Mainとして使いたいため
# クラス名をつけている
class_name Main

var _game_sounds:GameSounds

func _ready():
	level_up()
	load_game()
	# 音源をロード
	_sound_load()
	# BGMを鳴らす
	_play_musmus_BGM_090()

# 音源をロード
func _sound_load():
	_game_sounds = GameSounds.new()
	_game_sounds.sound_load(self)

# BGMを鳴らす
func _play_musmus_BGM_090():
	_game_sounds.play_musmus_BGM_090(2)

# ヒット音を鳴らす（ぶつかったときの音）
# Mainでは呼び出さない。
# 各ゲームステージの中から呼び出される
func play_hit08_1():
	_game_sounds.play_hit08_1()

# シャッター音を鳴らす（プレイヤーの歩く音）
# Mainでは呼び出さない。
# 各ゲームステージの中から呼び出される
func play_shutter_01_1():
	_game_sounds.play_shutter_01_1()

func _process(delta):
	# Main では _processでは何もしない。
	# _processがあるのは、各ゲームシーンのタイルマップスクリプトである
	pass
