extends Node

#===============================================
# GameConstants.gd
#
# ゲームにて使用するコンスタント値をここにまとめる。
#===============================================

#-----------------------------------------------
# Player 関係
#-----------------------------------------------

# メタデータのキー
const Map_Position_Key := "map_position"

# SpriteSheetタイプのTextureを使うので
# 上下左右を向いたキャラのV方向の位置を定義する
const Frame_Left :int = 0
const Frame_Up :int = 1
const Frame_Right :int = 2
const Frame_Down :int = 3

# 上下左右の移動の変化量(タイルマップ上の変化量)
const Dir_Right := Vector2i(1,0)
const Dir_Left := Vector2i(-1,0)
const Dir_Up := Vector2i(0,-1)
const Dir_Down := Vector2i(0,1)

#-----------------------------------------------
# TileMap 関係
#-----------------------------------------------

# タイルマップレイアーID
# タイルマップにレイアーは１個だけ
const Layer_Tile_Data : int = 0

# カスタムデータレイヤーID
# カスタムデータ（タイル種別） 先頭のデータレイヤー
const Layer_Data_Kind : int = 0

# カスタムデータ(タイル種別)
# (注意事項) 
# Tileのカスタムデータ(1番目)には下記の文字列を設定すること！
const Wall          := 'Wall'
const Arrow_Right   := 'Arrow_Right'
const Arrow_Left    := 'Arrow_Left'
const Arrow_Up      := 'Arrow_Up'
const Arrow_Down    := 'Arrow_Down'
const Teleport_1    := 'Teleport_1'
const Teleport_2    := 'Teleport_2'
const Door          := 'Door'
const Lever_Off     := 'Lever_Off'
const Lever_On      := 'Lever_On'
const Mark_Circle_W := 'Mark_Circle_W'
const Mark_Cone_W   := 'Mark_Cone_W'
const Mark_Circle_R := 'Mark_Circle_R'
const Mark_Cone_R   := 'Mark_Cone_R'
const Cage          := 'Cage'
const Box_Brown     := 'Box_Brown'
const Box_Red       := 'Box_Red'
const Box_Blue      := 'Box_Blue'
const Box_Green     := 'Box_Green'
const Button_On     := 'Button_On'
const Button_Off    := 'Button_Off'

# カスタムデータ先頭の目印
const Arrow    := 'Arrow'
const Lever    := 'Lever'
const Teleport := 'Teleport'


# ソースID
# (注意事項) 
# TileSetへソースを追加するときは 下記のソースIDと一致させること！
const Source_Id_Wall      := 0  # 壁
const Source_Id_Arrows    := 1  # 矢印
const Source_Id_Teleports := 2  # テレポート
const Source_Id_Door      := 3  # ドア
const Source_Id_Levers    := 4  # レバー
const Source_Id_Marks     := 5  # マーク
const Source_Id_Cages     := 6  # かご(小屋)
const Source_Id_Boxes     := 7  # 箱
const Source_Id_Buttons   := 8  # ボタン

# Atras_Coords 連想配列
# (注意事項) 
# TileSetへソースを追加したときの Atras Coordsを転機すること
# 使いそうなものだけを転機すればよい。全部を書くのは大変だからね。
const Atras_Coords = {
	Wall           : Vector2i(0,0), # 壁
	Arrow_Right    : Vector2i(0,0), # 右向き矢印
	Arrow_Up       : Vector2i(1,0), # 上向き矢印
	Arrow_Down     : Vector2i(2,0), # 下向き矢印
	Arrow_Left     : Vector2i(3,0), # 左向き矢印
	Teleport       : Vector2i(0,0), # テレポート
	Door           : Vector2i(0,0), # ドア
	Lever_Off      : Vector2i(0,0), # レバーOFF
	Lever_On       : Vector2i(1,0), # レバーON
	Mark_Circle_W  : Vector2i(0,0), # 円のマーク白
	Mark_Cone_W    : Vector2i(2,0), # 円錐のマーク白
	Mark_Circle_R  : Vector2i(4,0), # 円のマーク赤
	Mark_Cone_R    : Vector2i(6,0), # 円錐のマーク赤
	Cage           : Vector2i(0,0), # かご
	Box_Brown      : Vector2i(0,0), # 箱(茶色)
	Box_Red        : Vector2i(1,0), # 箱(赤色)
	Box_Blue       : Vector2i(0,1), # 箱(青色)
	Box_Green      : Vector2i(1,1), # 箱(緑色)
	Button_Off     : Vector2i(0,0), # ボタンOff
	Button_On      : Vector2i(1,0), # ボタンON
}

# Alternative Tile 連想配列
# (注意事項) 
# TileSetへソースを追加したときの Alternative Tile の番号を転機すること
# 使いそうなものだけを転機すればよい。全部を書くのは大変だからね。
const Alternative_Tiles = {
	Teleport_1 : 1,
	Teleport_2 : 2,
}
