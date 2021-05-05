extends Camera2D

# Get player
onready var player = get_parent().get_node("player")

# Set position to player position
func _process(delta):
	global_position.x = player.global_position.x
	global_position.y = player.global_position.y
	
