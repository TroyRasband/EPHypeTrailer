extends Area2D

onready var player = get_parent()

func get_hurt(var direction):
	player.health = player.health - 1
	player.knockback = Vector2.RIGHT * direction
	if (direction < 0):
		player.orientation = player.direction.RIGHT
	if (direction > 0):
		player.orientation = player.direction.LEFT
	player.change_state(player.state_machine_player.HIT)
	if (player.health <= 0):
		player.not_dead = false
