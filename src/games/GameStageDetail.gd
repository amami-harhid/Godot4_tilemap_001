extends GameCommon

#===================================
# GameNN.gd の親クラス
# 各ステージで使われるが、Commonにするほどの
# ことではないものをまとめる
#===================================

class_name GameStageDetail

# 『壁』タイルの判定
func _is_wall_tile(_tile_data:TileData)->bool:
	if _tile_data :
		var _tile_kind:String = Commons.get_tile_data_kind(_tile_data)
		if _tile_kind == GameConstants.Wall:
			# 『壁』です
			main.play_hit08_1()
			return true
	# タイルがないときは『壁』ではないです
	return false

# 『レバー』タイルをオンにする
func _replace_to_lever_on(_pos:Vector2i):
	var _lever_on := GameConstants.Lever_On
	var _altras = GameConstants.Atras_Coords
	Commons.replace_cell(self, _pos, GameConstants.Source_Id_Levers, _altras.get(_lever_on))
	main.play_hit08_1()

# 『ボタン』タイルをオンにする
func _replace_to_button_on(_pos:Vector2i):
	var _button_on := GameConstants.Button_On
	var _altras = GameConstants.Atras_Coords
	Commons.replace_cell(self, _pos, GameConstants.Source_Id_Buttons, _altras.get(_button_on))
	main.play_hit08_1()
	
# 『ドア』タイルを出現させる
func _add_door_tile(_door_pos:Vector2i):
	var _altras = GameConstants.Atras_Coords
	var _door := GameConstants.Door
	Commons.set_cell(self,_door_pos, GameConstants.Source_Id_Door, _altras.get(_door))
	main.play_hit08_1()

# タイルマップ上のタイルを全検索し、指定マップ位置以外のタイルのなかで条件に合致するタイルがあれば
# 指定したアクションを実行する
# 指定条件、指定アクションは、Callableの形式で与える
func action_when_conditions(_condition1:Callable, _condition2:Callable, _action:Callable):
	var _curr_pos:Vector2i = player.get_map_position(self)
	var _rect:Rect2i = self.get_used_rect()
	for _y in range(_rect.size.y):
		for _x in range(_rect.size.x):
			var _pos:Vector2i = Vector2i(_x,_y)
			# 指定条件その１に合致することを確認する
			if _condition1.call(_pos):
				# 指定条件その２に合致することを確認する
				if _condition2.call(_pos):
					# 指定したアクションを実行する
					_action.call(_pos)
					# 最初にタイルを見つけた時点で捜索終了する
					return

# 矢印のマークの向きと移動しようとする向きが合致するとき True を返す
# Playerの現在地がないときは False
# Playerの現在地のタイルがないときは True(動ける)
func _match_arrows_direction(_dir:Vector2i)->bool:
	var _current_pos:Vector2i = player.get_map_position(self)
	var _tiledata:TileData = Commons.get_tile_data(self,_current_pos)
	if _tiledata :
		var _tile_kind:String = Commons.get_tile_data_kind(_tiledata)
		# 矢印タイルのとき向きが一致すれば Trueを返す
		var _escape:bool = false
		if _tile_kind == GameConstants.Arrow_Left:
			_escape = _dir == GameConstants.Dir_Left
		elif _tile_kind == GameConstants.Arrow_Right:
			_escape = _dir == GameConstants.Dir_Right
		elif _tile_kind == GameConstants.Arrow_Up:
			_escape = _dir == GameConstants.Dir_Up
		elif _tile_kind == GameConstants.Arrow_Down:
			_escape = _dir == GameConstants.Dir_Down
		else:
			# タイル種別が該当なしのとき
			_escape = true	
		
		# 脱出できないときは音を鳴らす
		if not _escape:
			main.play_hit08_1()

		return _escape
	else:
		# タイルがないとき
		return true
