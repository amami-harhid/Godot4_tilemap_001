extends Node

class_name GameSounds

const SoundsPath = 'res://assets/sounds/%s'
# BGM『MusMus』
# https://musmus.main.jp/piano.html
# 魔女っ婆タヱさん
# 音源はループ有効にしている
const MusMus_BGM_090 = SoundsPath % 'MusMus-BGM-090.mp3'
# BGM『OtoLogic』
# https://otologic.jp/free/se/flash01.html
# オノマトペ　光る10
const Onoma_Flash10_1 = SoundsPath % 'Onoma-Flash10-1_Low-1.mp3'
const Onoma_Flash10_2 = SoundsPath % 'Onoma-Flash10-2_Low-2.mp3'
#const Onoma_Flash10_3 = SoundsPath % 'Onoma-Flash10-3(Low-3).mp3'
#const Onoma_Flash10_4 = SoundsPath % 'Onoma-Flash10-4(Low-4).mp3'
const Hit08_1 = SoundsPath % 'Hit08-1.mp3'

var _asp_musmus_BGM_090: AudioStreamPlayer2D
var _asp_hit08_1: AudioStreamPlayer2D

func sound_load(_scene:Node2D):
	_asp_musmus_BGM_090 = AudioStreamPlayer2D.new()
	_asp_musmus_BGM_090.stream = load(MusMus_BGM_090)
	_scene.add_child(_asp_musmus_BGM_090)
	_asp_hit08_1 = AudioStreamPlayer2D.new()
	_asp_hit08_1.stream = load(Hit08_1)
	_scene.add_child(_asp_hit08_1)

func play_musmus_BGM_090(_pitch_scale:float):
	_asp_musmus_BGM_090.pitch_scale = _pitch_scale
	_asp_musmus_BGM_090.volume_db = -2
	_asp_musmus_BGM_090.play()

func play_hit08_1():
	_asp_hit08_1.volume_db = 10
	_asp_hit08_1.play()
