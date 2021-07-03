extends KinematicBody2D

# Identical to enemy but with some tweaks

# Initialize velocity and speed
var vel = Vector2.ZERO
var speed = 90
var is_hurt = false
var health = 50
var animation = "Move"
var dir

var knockback = Vector2.ZERO

# States for boss
var state
var type

onready var player
onready var animation_player = $AnimationPlayer

# State machines for boss
enum state_machine_boss {
	MOVE,
	HIT,
	ATTACK,
	DEAD
}

# Direction states
enum direction {
	LEFT,
	RIGHT
}

func _ready():
	state = state_machine_boss.MOVE
	player = get_parent().get_node("../PLAYER")
	
func _physics_process(delta):
	if (health <= 0):
		state = state_machine_boss.DEAD
	handle_sprite()
	vel = (player.position - position).normalized() * speed
	if state == state_machine_boss.MOVE:
		vel = move_and_slide(vel)
		if vel.x > 1:
			dir = direction.RIGHT
		if vel.x < -1:
			dir = direction.LEFT
	if vel.length() <= 40:
		change_state(state_machine_boss.ATTACK)
	if state == state_machine_boss.HIT:
		knockback = knockback.move_toward(Vector2.ZERO, 3000 * delta)
		knockback = move_and_slide(knockback)
	
	if (Level.complete == 1):
		state = state_machine_boss.DEAD

func change_state(_state):
	state = _state
	
func change_state_default():
	state = state_machine_boss.MOVE
	
func invisible():
	$BOSS_Sprite.visible = false

func handle_sprite():
	if (state == state_machine_boss.MOVE):
		animation = "Move"
	if (state == state_machine_boss.HIT):
		animation = "Hit"
	if (state == state_machine_boss.ATTACK):
		animation = "Attack"
	if (state == state_machine_boss.DEAD):
		animation = "Dead"
	if (dir == 1):
		$BOSS_Sprite.set_flip_h(false)
		$BoxPivot.scale.x = 1
	if (dir == 0):
		$BOSS_Sprite.set_flip_h(true)
		$BoxPivot.scale.x = -1
	animation_player.play(animation)

func _on_Hitbox_area_entered(area):
	if (area.is_in_group("Player_Hurtbox")):
		if (dir == 1):
			area.get_hurt(1000)
		if (dir == 0):
			area.get_hurt(-1000)
			
func get_health():
	return health
