extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 300
var animation = "Idle"
var attack
var block
var state = true
var prev_attack = "Attack_3"
var health = 16
var not_dead
var kills = 0

var knockback = Vector2.ZERO
var block_knockback = Vector2.ZERO

var state_m

onready var timer = get_node("AttackReset")
onready var player = $AnimationPlayer

enum state_machine_player {
	MOVE,
	HIT,
	ATTACK,
	IDLE,
	BLOCK
}

enum direction {
	LEFT,
	RIGHT
}

func _ready():
	state_m = state_machine_player.IDLE
	timer.set_wait_time(1)
	not_dead = true

# Handles physics processes including collision
func _physics_process(delta):
	if (not_dead):
		var input = Vector2.ZERO
		attack = Input.is_action_just_pressed("ui_accept")
	
		# If the attack animation is not playing
		if !attack && state(animation) == false && state_m != state_machine_player.HIT:
			# Returns the input values
			input.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
			input.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
		else:
			input = Vector2.ZERO
	
		if state_m == state_machine_player.HIT || state_m == state_machine_player.BLOCK:
			knockback = knockback.move_toward(Vector2.ZERO, 1000 * delta)
			knockback = move_and_slide(knockback)
		
		# If the animation is playing but the user attempts to input an attack, set attack to 0
		if state(animation):
			attack = 0
	
		vel = input.normalized() * speed * 60
		vel = move_and_slide(vel * delta)
	
		handle_sprite(input, vel, attack)
	
func handle_sprite(input, vel, attack):
	# Set animation to variable animation
	player.play(animation)
	
	# Check the state of the player animation; returns false if it's not attacking
	if !state(animation):
		# If the player is not moving, set the animation to "Idle", otherwise set it to run
		if vel == Vector2.ZERO:
			animation = "Idle"
		else:
			animation = "Move"
	
	# If the player inputs an attack, set the animation to an attack animation
	handle_attack()

	# Flip sprite depending on what direction the player is facing
	if input.x == -1:
		$PLAYER_Sprite.set_flip_h(true)
		$BoxPivot.scale.x = -1
	if input.x == 1:
		$PLAYER_Sprite.set_flip_h(false)
		$BoxPivot.scale.x = 1
		
	if state_m == state_machine_player.HIT:
		block = 0
		animation = "Hit"
	
	if state_m == state_machine_player.BLOCK:
		animation = "Block"

# Handles animation state; returns true if the attack animation is playing; false otherwise
func state(animation):
	if ((animation == "Attack_1") || (animation == "Attack_2") ||
	(animation == "Attack_3")):
		state = true
	else:
		state = false
	return state

# Check if the player inputs an attack
func handle_attack():
	if attack:
		if (prev_attack == "Attack_3") && timer.time_left == 0:
			animation = "Attack_1"
			$Sound_Punch.play()
			swap()
			reset_timer()
			return
		if (prev_attack == "Attack_1"):
			animation = "Attack_2"
			$Sound_Punch.play()
			swap()
			reset_timer()
			return
		if (prev_attack == "Attack_2"):
			animation = "Attack_3"
			$Sound_Punch.play()
			swap()
			timer.set_wait_time(1)
			timer.stop()
			return

# Changes prev_animation to current animation
func swap():
	prev_attack = animation

# Resets animation to Idle
func reset():
	animation = "Idle"

# Reset the timer
func reset_timer():
	timer.stop()
	timer.set_wait_time(1)
	timer.start()

# Check if hitbox connects with hurtbox
func _on_Hitbox_area_entered(area):
	if (area.is_in_group("Hurtbox")):
		area.get_hurt()
		$Sound_Hit.play()
	if (area.is_in_group("Hurtbox") && animation == "Attack_3"):
		area.get_hurt_really_bad()
	if (area.is_in_group("Hurtbox")):
		if (area.get_parent().get_health() < 1):
			kills = kills + 1
			print(kills)

func get_kills():
	return kills

# Gets called when time runs out
func _on_AttackReset_timeout():
	prev_attack = "Attack_3"
	timer.stop()
	
func change_state(_state):
	state_m = _state
	
func change_state_def():
	state_m = state_machine_player.IDLE
