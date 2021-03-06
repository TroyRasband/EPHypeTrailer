extends KinematicBody2D

# Initialize velocity and speed
var vel = Vector2.ZERO
var speed = 120
var is_hurt = false
var health = 6
var animation = "Move"
var dir

var knockback = Vector2.ZERO

# States for enemy
var state
var type

# Obtain the player
onready var enemy_spawn
onready var player
onready var animation_player = $AnimationPlayer

onready var enemy_sprites = [load("res://scenes/gameplay_ph/enemy/enemy_sheet_1.png"),
							load("res://scenes/gameplay_ph/enemy/enemy_sheet_2.png"),
							load("res://scenes/gameplay_ph/enemy/enemy_sheet_3.png"),
							load("res://scenes/gameplay_ph/enemy/enemy_sheet.png")]

# Expermenting with state machines for enemy
enum state_machine_enemy {
	MOVE,
	HIT,
	ATTACK,
	DEAD
}

enum direction {
	LEFT,
	RIGHT
}

func _ready():
	state = state_machine_enemy.MOVE
	$ENEMY_Sprite.set_texture(enemy_sprites[Level.level])
	player = get_parent().get_node("../PLAYER")
	enemy_spawn = get_parent().get_parent().get_node("../Spawn_Enemy")

func _physics_process(delta):
	
	if (health <= 0):
		state = state_machine_enemy.DEAD
	
	handle_sprite()
	vel = (player.position - position).normalized() * speed
	if state == state_machine_enemy.MOVE:
		vel = move_and_slide(vel)
		if vel.x > 1:
			dir = direction.RIGHT
		if vel.x < -1:
			dir = direction.LEFT
	if vel.length() <= 40:
		if (Level.enemy_attack == 0):
			change_state(state_machine_enemy.ATTACK)
	if (state == state_machine_enemy.ATTACK):
		Level.enemy_attack = 1
	else:
		Level.enemy_attack = 0
	if state == state_machine_enemy.HIT:
		knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)
		knockback = move_and_slide(knockback)
	
	if (Level.complete == 1):
		state = state_machine_enemy.DEAD
	
func get_health():
	return health
	
func set_health(health):
	self.health = health

func reset_attack():
	Level.enemy_attack = 0

func change_state(_state):
	state = _state

func change_state_default():
	state = state_machine_enemy.MOVE

func handle_sprite():
	if (state == state_machine_enemy.MOVE):
		animation = "Move"
	if (state == state_machine_enemy.HIT):
		animation = "Hit"
	if (state == state_machine_enemy.ATTACK):
		animation = "Attack"
	if (state == state_machine_enemy.DEAD):
		animation = "Dead"
	if (dir == 1):
		$ENEMY_Sprite.set_flip_h(false)
		$BoxPivot.scale.x = 1
	if (dir == 0):
		$ENEMY_Sprite.set_flip_h(true)
		$BoxPivot.scale.x = -1
	animation_player.play(animation)

func invisible():
	$ENEMY_Sprite.visible = false

func _on_Hitbox_area_entered(area):
	if (area.is_in_group("Player_Hurtbox")):
		if (dir == 1):
			area.get_hurt(500)
		if (dir == 0):
			area.get_hurt(-500)
		
func play_hurt_sound():
	$Sound_ENEMYHit.play()
	
func play_attack_sound():
	$Sound_ENEMYPunch.play()
