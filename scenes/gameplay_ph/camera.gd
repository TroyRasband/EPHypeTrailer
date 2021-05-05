extends Camera2D

onready var TL = get_node("Node/TL_L")
onready var BR = get_node("Node/BR_L")

func _ready():
	limit_top = TL.position.y
	limit_bottom = BR.position.y
	limit_left = TL.position.x
	limit_right = BR.position.x
	
