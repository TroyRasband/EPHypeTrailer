extends Area2D

var is_hurt = false

onready var enemy = get_parent()

func get_hurt():
	if (enemy.dir == enemy.direction.RIGHT):
		enemy.knockback = Vector2.LEFT * 1000
	if (enemy.dir == enemy.direction.LEFT):
		enemy.knockback = Vector2.RIGHT * 1000
	enemy.animation_player.stop()
	enemy.change_state(enemy.state_machine_enemy.HIT)
