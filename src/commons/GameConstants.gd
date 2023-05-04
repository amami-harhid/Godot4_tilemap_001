extends Node


const Map_Position_Key := "map_position"
const Frame_Left :int = 0
const Frame_Up :int = 1
const Frame_Right :int = 2
const Frame_Down :int = 3

const Dir_Right := Vector2i(1,0)
const Dir_Left := Vector2i(-1,0)
const Dir_Up := Vector2i(0,-1)
const Dir_Down := Vector2i(0,1)

#--- TileMap Layer ----#
const Layer_Tile_Data : int = 0 # タイルマップにレイアーは１個だけ

#--- Custom Data Layer ----#
const Layer_Data_Kind : int = 0 # カスタムデータ（タイル種別） 先頭のデータレイヤー

#--- Custom Data ( Tile Type ) ----#
const Wall := 'Wall'
const Arrow := 'Arrow'
const Arrow_Right := 'Arrow_Right'
const Arrow_Left := 'Arrow_Left'
const Arrow_Up := 'Arrow_Up'
const Arrow_Down := 'Arrow_Down'
const Teleport := 'Teleport'
const Door := 'Door'
const Lever := 'Lever'
const Lever_Off := 'Lever_Off'
const Lever_On := 'Lever_On'
const Lever_Off_1 := 'Lever_Off_1'

#--- Source_Id ----#
const Source_Id_Wall := 0
const Source_Id_Arrows := 1
const Source_Id_Teleports := 2
const Source_Id_Door := 3
const Source_Id_Levers := 4
const Source_Id_Marks := 5
const Source_Id_Cages := 6
const Source_Id_Boxes := 7
const Source_Id_Buttons := 8

#--- Atras_Coords ----#
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
const Atras_Coords = {
	Atras_Coords_Key.Arrow_Right : Vector2i(0,0),
	Atras_Coords_Key.Arrow_Up : Vector2i(1,0),
	Atras_Coords_Key.Arrow_Down : Vector2i(2,0),
	Atras_Coords_Key.Arrow_Left : Vector2i(3,0),
	Atras_Coords_Key.Teleport : Vector2i(0,0),
	Atras_Coords_Key.Door : Vector2i(0,0),
	Atras_Coords_Key.Lever_Off : Vector2i(0,0),
	Atras_Coords_Key.Lever_On : Vector2i(1,0),
	Atras_Coords_Key.Marks_Circle_W : Vector2i(0,0),
	Atras_Coords_Key.Marks_Cone_W : Vector2i(2,0),
	Atras_Coords_Key.Marks_Circle_R : Vector2i(4,0),
	Atras_Coords_Key.Marks_Cone_R : Vector2i(6,0),
	
}

#--- Alternative Tile ----#
enum Alternative_Tiles_Key {
	Teleport_1 = 0,
	Teleport_2 = 1,
}
const Alternative_Tiles = {
	Alternative_Tiles_Key.Teleport_1 : 1,
	Alternative_Tiles_Key.Teleport_2 : 2,
}
