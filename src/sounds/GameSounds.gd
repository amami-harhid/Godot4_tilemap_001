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
const Hit08_1 = SoundsPath % 'Hit08-1.mp3'
const Shutter_01_1 = SoundsPath % 'Camera-Disposable01-1_Shutter.mp3'

var _asp_musmus_BGM_090: AudioStreamPlayer2D
var _asp_hit08_1: AudioStreamPlayer2D
var _asp_shutter_01_1: AudioStreamPlayer2D

func sound_load(_scene:Node2D):
	_asp_musmus_BGM_090 = AudioStreamPlayer2D.new()
	_asp_musmus_BGM_090.stream = load(MusMus_BGM_090)
	_scene.add_child(_asp_musmus_BGM_090)
	_asp_hit08_1 = AudioStreamPlayer2D.new()
	_asp_hit08_1.stream = load(Hit08_1)
	_scene.add_child(_asp_hit08_1)
	_asp_shutter_01_1 = AudioStreamPlayer2D.new()
	_asp_shutter_01_1.stream = load(Shutter_01_1)
	_scene.add_child(_asp_shutter_01_1)

func play_musmus_BGM_090(_pitch_scale:float):
	_asp_musmus_BGM_090.pitch_scale = _pitch_scale
	_asp_musmus_BGM_090.volume_db = -2
	_asp_musmus_BGM_090.play()

func play_hit08_1():
	_asp_hit08_1.volume_db = 10
	_asp_hit08_1.play()

func play_shutter_01_1():
	_asp_shutter_01_1.volume_db = -5
	_asp_shutter_01_1.play()
