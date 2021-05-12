extends Area2D

onready var player = get_parent()
onready var enemy = get_parent().get_parent().get_node("ENEMY")

func get_hurt():
	player.health = player.health - 1
	if (enemy.dir == enemy.direction.RIGHT):
		player.knockback = Vector2.RIGHT * 500
	if (enemy.dir == enemy.direction.LEFT):
		player.knockback = Vector2.LEFT * 500
	player.change_state(player.state_machine_player.HIT)
	if (player.health <= 0):
		player.not_dead = false
