extends Node

onready var region_TL = get_parent().get_node("Spawn_Region_TL")
onready var region_BR = get_parent().get_node("Spawn_Region_BR")
onready var restrict_spawn_TL = get_parent().get_node("YSort/PLAYER/Restrict_Spawn_TL")
onready var restrict_spawn_BR = get_parent().get_node("YSort/PLAYER/Restrict_Spawn_BR")
onready var timer = $Spawn_Time
onready var enemy 
onready var scene = get_parent().get_node("YSort")

onready var maxed_out

onready var player = get_parent().get_node("YSort/PLAYER")

onready var time = 6

var rng_x_1 = RandomNumberGenerator.new()
var rng_x_2 = RandomNumberGenerator.new()

var rng_y_1 = RandomNumberGenerator.new()
var rng_y_2 = RandomNumberGenerator.new()

var max_enemies = 5
var enemies = 0

var enemies_killed = 0

var max_kills = 15 + (10 * Level.level)

func _ready():
	maxed_out = false
	randomize()
	timer.set_wait_time(time)
	timer.start()
	
func _physics_process(delta):
	if (enemies >= max_enemies):
		maxed_out = true
	else:
		maxed_out = false
	
	time = (6 - (6 * (player.get_kills() * (float(1)/float(max_kills)))))
	
	if (time < 3):
		time = 3
	if (player.get_kills() == max_kills):
		timer.stop()

func spawn():
	if (time > 0):
		if (enemies <= max_enemies - 1):
			enemy = preload("res://scenes/gameplay_ph/enemy/enemy_scene.tscn")
			enemy = enemy.instance()
			enemies = enemies + 1
			print("Enemies on screen: " + str(enemies))
			scene.add_child(enemy)
		
			enemy.get_node("ENEMY").position.x = random_x()
			enemy.get_node("ENEMY").position.y = random_y()

func random_x():
	rng_x_1 = rand_range(region_TL.position.x, restrict_spawn_TL.global_position.x)
	rng_x_2 = rand_range(region_BR.position.x, restrict_spawn_BR.global_position.x)
	var which_x = [rng_x_1, rng_x_2]
	var rng_x = which_x[randi() % which_x.size()]
	return rng_x

func random_y():
	rng_y_1 = rand_range(region_TL.position.y, restrict_spawn_BR.global_position.y)
	rng_y_2 = rand_range(region_BR.position.y, restrict_spawn_BR.global_position.y)
	var which_y = [rng_y_1, rng_y_2]
	var rng_y = which_y[randi() % which_y.size()]
	return rng_y

func _on_Spawn_Time_timeout():
	if (Level.complete == 0):
		if (!maxed_out):
			spawn()
			timer.set_wait_time(time)
