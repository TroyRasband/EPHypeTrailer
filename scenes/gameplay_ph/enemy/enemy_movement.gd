extends KinematicBody2D

# Initialize velocity and speed
var vel = Vector2.ZERO
var speed = 120
var is_hurt = false
var health = 2

# Obtain the player
onready var player = get_parent().get_node("PLAYER")

func _physics_process(_delta):
	vel = (player.position - position).normalized() * speed
	vel = move_and_slide(vel.floor())
	
func get_health():
	return health
	
func set_health(health):
	self.health = health
