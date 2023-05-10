extends MainCommon

class_name MainDetail

enum Game_Level {
	Game_Level_Undefined = -1, # ゲームレベル未設定
	Game_Level_First = 4, # 最初のゲームレベル
	Game_Level_Final = 4, # 最後のゲームレベル
}

var _level:Game_Level = Game_Level.Game_Level_Undefined

# ステージレベルを初期化
func setup():
	_level = Game_Level.Game_Level_First

# ステージレベルアップさせる
# 最後のレベルのときは最初に戻る
func level_up():
	if _level == Game_Level.Game_Level_Undefined:
		_level = Game_Level.Game_Level_First
	elif _level < Game_Level.Game_Level_Final:
		_level += 1
	else:
		_level = Game_Level.Game_Level_First

# Levelのパス	
const Path_Level_Tscn = "res://resources/stage/Stage%02d.tscn"

# 所定の秒数の後、ゲーム（ステージ）をロードする
func load_game():
	# ロードする前にタイルマップレイヤーを隠す
	canvasLayerTilemap.hide()
	# ロードする前にプレイヤーレイヤーを消す
	canvasLayerPlayer.hide()
	var _loader := Callable(self,'_load_game')
	var _wait_time := 1.2
	Commons.one_shot_timer(_wait_time, _loader)
	pass

# ゲーム（ステージ）をロードする
func _load_game():
	var _child_count = canvasLayerTilemap.get_child_count()
	if _child_count > 0:
		# 子ノードがあるとき
		# 子ノードを消す
		for _node in canvasLayerTilemap.get_children():
			if _node.name == "GameScene":
				canvasLayerTilemap.remove_child(_node)
		
	# Level(Node2D)を読み込む
	var _level_path = Path_Level_Tscn%_level # %02d を数字に置換
	# ゲームシーンをロード
	var _level_res = load(_level_path)
	# ゲームシーンのインスタンスを作成
	var _level_obj:Node2D = _level_res.instantiate()
	# ゲームシーンを１つ奥にする（意味がないかもしれない）
	_level_obj.z_index = -1
	# 子ノードとして追加する
	canvasLayerTilemap.add_child(_level_obj)
	# タイルマップレイヤーを表示する
	canvasLayerTilemap.show()
	# プレイヤーレイヤーを表示する
	canvasLayerPlayer.show()
