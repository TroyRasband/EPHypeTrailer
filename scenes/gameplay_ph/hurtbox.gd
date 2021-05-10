extends Area2D

var is_hurt = false

onready var enemy = get_parent()

func get_hurt():
	if enemy.get_health() > 0:
		enemy.set_health(enemy.get_health() - 1)
	else:
		enemy.queue_free()
