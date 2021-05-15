extends Area2D

onready var player = get_parent().get_parent()
onready var enemy

func block_attack():
	enemy = get_parent().get_parent().get_parent().get_node("Node2D").get_node("ENEMY")
	if (enemy.dir == enemy.direction.RIGHT):
		player.knockback = Vector2.RIGHT * 200
	if (enemy.dir == enemy.direction.LEFT):
		player.knockback = Vector2.LEFT * 200
