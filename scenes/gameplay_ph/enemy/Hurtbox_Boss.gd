extends Area2D

onready var boss = get_parent()

func get_hurt():
	boss.health = boss.health - 1
	if (boss.dir == boss.direction.RIGHT):
		boss.knockback = Vector2.LEFT * 200
	if (boss.dir == boss.direction.LEFT):
		boss.knockback = Vector2.RIGHT * 200
	boss.animation_player.stop()
	boss.change_state(boss.state_machine_boss.HIT)
	
func get_hurt_really_bad():
	boss.health = boss.health - 2
	if (boss.dir == boss.direction.RIGHT):
		boss.knockback = Vector2.LEFT * 800
	if (boss.dir == boss.direction.LEFT):
		boss.knockback = Vector2.RIGHT * 800
	boss.animation_player.stop()
	boss.change_state(boss.state_machine_boss.HIT)
