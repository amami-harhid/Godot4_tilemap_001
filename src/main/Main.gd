extends MainDetail

# Gameのスクリプト(GameCommon)の中で Mainとして使いたいため
# クラス名をつけている
class_name Main

func _ready():
	level_up()
	load_game()

func _process(delta):
	pass
