extends KinematicBody2D

# Initialize velocity and speed
var vel = Vector2.ZERO
var speed = 120

# Obtain the player
onready var player = get_parent().get_node("player/Sprite")

func _physics_process(_delta):
	vel = (player.global_position - global_position).normalized() * speed
	move_and_slide(vel)
