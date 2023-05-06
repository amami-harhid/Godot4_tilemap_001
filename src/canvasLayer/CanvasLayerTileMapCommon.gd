extends CanvasLayer

class_name CanvasLayerTileMapCommon

# プレイヤーCanvasレイヤー
@onready var canvasLayerPlayer:CanvasLayer = get_node('../CanvasLayerPlayer')

enum Game_Level {
	Game_Level_Undefined = -1, # ゲームレベル未設定
	Game_Level_First = 1, # 最初のゲームレベル
	Game_Level_Final = 3, # 最後のゲームレベル
}

var _level:Game_Level = Game_Level.Game_Level_Undefined

func setup():
	_level = Game_Level.Game_Level_First

func level_up():
	if _level == Game_Level.Game_Level_Undefined:
		_level = Game_Level.Game_Level_First
	elif _level < Game_Level.Game_Level_Final:
		_level += 1
	else:
		_level = Game_Level.Game_Level_First

# Levelのパス	
const Path_Level_Tscn = "res://resources/level/Level%02d.tscn"

func load_game():
	# ロードする前にレイヤーを隠す
	self.hide()
	# ロードする前にプレイヤーレイヤーを消す
	canvasLayerPlayer.hide()
	var _load_game := Callable(self,'_load_game')
	Commons.one_shot_timer(0.2, _load_game)
	pass

func _load_game():
	var _child_count = self.get_child_count()
	if _child_count > 0:
		# 子ノードがあるとき
		# 子ノードを消す
		for _node in self.get_children() :
			self.remove_child(_node)
		
	# Level(Node2D)を読み込む
	var _level_path = Path_Level_Tscn%_level # %02d を数字に置換
	var _level_res = load(_level_path)
	# インスタンスを作成
	var _level_obj = _level_res.instantiate()
	# 子ノードとして追加する
	self.add_child(_level_obj)
	# レイヤーを表示する
	self.show()
	# プレイヤーレイヤーを表示する
	canvasLayerPlayer.show()
