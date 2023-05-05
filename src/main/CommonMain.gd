extends Node2D

#===================================
# Main.gd の親クラス
#===================================

class_name CommonMain

@onready var canvasLayerTilemap:CanvasLayerTileMapCommon = $CanvasLayerTileMap
@onready var canvasLayerPlayer:CanvasLayer = $CanvasLayerPlayer
@onready var player:Sprite2D = $CanvasLayerPlayer/PlayerSprite2D

func level_up():
	canvasLayerTilemap.level_up()

func load_game():
	canvasLayerTilemap.load_game()
