extends Area2D

onready var enemy = get_parent()
onready var enemy_spawn = get_parent().get_parent().get_parent().get_parent().get_node("Spawn_Enemy")

func get_hurt():
	enemy.health = enemy.health - 1
	if (enemy.dir == enemy.direction.RIGHT):
		enemy.knockback = Vector2.LEFT * 200
	if (enemy.dir == enemy.direction.LEFT):
		enemy.knockback = Vector2.RIGHT * 200
	enemy.animation_player.stop()
	enemy.change_state(enemy.state_machine_enemy.HIT)
	check_death()

# ;)
func get_hurt_really_bad():
	enemy.health = enemy.health - 2
	if (enemy.dir == enemy.direction.RIGHT):
		enemy.knockback = Vector2.LEFT * 500
	if (enemy.dir == enemy.direction.LEFT):
		enemy.knockback = Vector2.RIGHT * 500
	enemy.animation_player.stop()
	enemy.change_state(enemy.state_machine_enemy.HIT)
	check_death()
	
func check_death():
	if (enemy.health <= 0):
		enemy_spawn.enemies = enemy_spawn.enemies - 1
