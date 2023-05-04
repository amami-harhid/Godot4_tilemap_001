extends CommonMain

#-----------------------
# onready
#-----------------------
@onready var canvasLayerBackground:CanvasLayer = $CanvasLayerBackground
#@onready var canvasLayerTilemap:CanvasLayer = $CanvasLayerTileMap
#@onready var canvasLayerPlayer:CanvasLayer = $CanvasLayerPlayer
@onready var canvasLayerPanel:CanvasLayer = $CanvasLayerPanel

func _ready():
	level_up()
	load_game()

func _process(delta):
	pass
