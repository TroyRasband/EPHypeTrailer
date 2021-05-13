extends Node

onready var region_TL = get_parent().get_node("Spawn_Region_TL")
onready var region_BR = get_parent().get_node("Spawn_Region_BR")
onready var restrict_spawn_TL = get_parent().get_node("YSort/PLAYER/Restrict_Spawn_TL")
onready var restrict_spawn_BR = get_parent().get_node("YSort/PLAYER/Restrict_Spawn_BR")
onready var timer = $Spawn_Time
onready var enemy 
onready var scene = get_parent().get_node("YSort")

var rng_x_1 = RandomNumberGenerator.new()
var rng_x_2 = RandomNumberGenerator.new()

var rng_y_1 = RandomNumberGenerator.new()
var rng_y_2 = RandomNumberGenerator.new()

var delta_x
var delta_y

var max_enemies = 5
var enemies = 0

func _ready():
	randomize()
	timer.set_wait_time(6)
	timer.start()

func spawn():
	if (enemies <= max_enemies - 1):	
		enemy = preload("res://scenes/gameplay_ph/enemy/enemy_scene.tscn")
		enemy = enemy.instance()
		enemies = enemies + 1
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
	spawn()
	timer.stop()
	timer.set_wait_time(6)
	timer.start()
