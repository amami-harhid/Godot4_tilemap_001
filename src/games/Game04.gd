extends TileMap

@onready var main:Node2D = get_tree().root.get_node("Main")
@onready var player:Sprite2D = main.get_node("CanvasLayerPlayer/PlayerSprite2D")
@onready var girl:RigidBody2D = $RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player.visible = false	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var force = Vector2(0,0)
	var impulse = Vector2(0,0)
	if shape_entered:
		if Input.is_action_just_pressed("ui_up"):
			impulse += Vector2(0,-2)
		if Input.is_action_just_pressed("ui_right"):
			impulse += Vector2(2,0)
		if Input.is_action_just_pressed("ui_left"):
			impulse += Vector2(-2,0)
		if not impulse == Vector2(0,0):
			girl.apply_central_impulse(impulse)
	if Input.is_action_pressed("ui_right"):
		force += Vector2(5,0)
	if Input.is_action_pressed("ui_left"):
		force += Vector2(-5,0)
	if shape_entered && not force == Vector2(0,0):
		girl.apply_central_force(force)
	pass


func _on_rigid_body_2d_body_entered(body):
	#print(body)
	pass # Replace with function body.

var shape_entered = false
func _on_rigid_body_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("entered")
	#print(body_rid,body,local_shape_index)
	shape_entered = true
	pass # Replace with function body.



func _on_rigid_body_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	shape_entered = false
	print("exit")
	pass # Replace with function body.
