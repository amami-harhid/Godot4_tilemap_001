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
const Wall         := 'Wall'
const Arrow_Right  := 'Arrow_Right'
const Arrow_Left   := 'Arrow_Left'
const Arrow_Up     := 'Arrow_Up'
const Arrow_Down   := 'Arrow_Down'
const Teleport     := 'Teleport'
const Door         := 'Door'
const Lever_Off    := 'Lever_Off'
const Lever_On     := 'Lever_On'
const Lever_Off_1  := 'Lever_Off_1'
const Lever_Off_2  := 'Lever_Off_2'

# カスタムデータ先頭の目印
const Arrow := 'Arrow'
const Lever := 'Lever'


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

# Atras_Coords Key
# - Atras_Coords 連想配列のキーとして使うもの（値はユニークにすること）
enum Atras_Coords_Key {
	Wall = 0,
	Arrow_Right = 1,
	Arrow_Up = 2,
	Arrow_Down = 3,
	Arrow_Left = 4,
	Teleport = 5,
	Door = 6,
	Lever_Off = 7,
	Lever_On = 8,
	Marks_Circle_W = 9,
	Marks_Cone_W = 10,
	Marks_Circle_R = 11,
	Marks_Cone_R = 12,
}
# Atras_Coords 連想配列
# (注意事項) 
# TileSetへソースを追加したときの Atras Coordsを転機すること
# 使いそうなものだけを転機すればよい。全部を書くのは大変だからね。
const Atras_Coords = {
	Atras_Coords_Key.Arrow_Right    : Vector2i(0,0), # 右向き矢印
	Atras_Coords_Key.Arrow_Up       : Vector2i(1,0), # 上向き矢印
	Atras_Coords_Key.Arrow_Down     : Vector2i(2,0), # 下向き矢印
	Atras_Coords_Key.Arrow_Left     : Vector2i(3,0), # 左向き矢印
	Atras_Coords_Key.Teleport       : Vector2i(0,0), # テレポート
	Atras_Coords_Key.Door           : Vector2i(0,0), # ドア
	Atras_Coords_Key.Lever_Off      : Vector2i(0,0), # レバーOFF
	Atras_Coords_Key.Lever_On       : Vector2i(1,0), # レバーON
	Atras_Coords_Key.Marks_Circle_W : Vector2i(0,0), # 円のマーク白
	Atras_Coords_Key.Marks_Cone_W   : Vector2i(2,0), # 円錐のマーク白
	Atras_Coords_Key.Marks_Circle_R : Vector2i(4,0), # 円のマーク赤
	Atras_Coords_Key.Marks_Cone_R   : Vector2i(6,0), # 円錐のマーク赤
}

# Alternative Tile Key
# - Alternative Tile 連想配列のキーとして使うもの（値はユニークにすること）
enum Alternative_Tiles_Key {
	Teleport_1 = 0,
	Teleport_2 = 1,
}
# Alternative Tile 連想配列
# (注意事項) 
# TileSetへソースを追加したときの Alternative Tile の番号を転機すること
# 使いそうなものだけを転機すればよい。全部を書くのは大変だからね。
const Alternative_Tiles = {
	Alternative_Tiles_Key.Teleport_1 : 1,
	Alternative_Tiles_Key.Teleport_2 : 2,
}
