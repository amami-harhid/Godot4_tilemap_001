extends Node2D

#===================================
# Main.gd の親クラス
#===================================

class_name MainCommon

#-----------------------------------
# onready
#-----------------------------------
@onready var canvasLayerTilemap:CanvasLayer = $CanvasLayerTileMap
#@onready var canvasLayerTilemapNode2d:Node2D = $CanvasLayerTileMap/Node2D
@onready var canvasLayerPlayer:CanvasLayer = $CanvasLayerPlayer
@onready var player:Sprite2D = $CanvasLayerPlayer/PlayerSprite2D
