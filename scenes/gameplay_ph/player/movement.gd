extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 200
var animation = "Idle"
var attack
var state = true
var prev_attack

# Handles physics processes including collision
func _physics_process(delta):
	var input = Vector2.ZERO
	attack = Input.is_action_just_pressed("ui_accept")
	
	# If the attack animation is not playing
	if !attack && state(animation) == false:
		# Returns the input values
		input.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
		input.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	else:
		input = Vector2.ZERO
	
	vel = input.normalized() * speed * 60 * delta
	vel = move_and_slide(vel)
	
	handle_sprite(input, vel, attack)
	
func handle_sprite(input, vel, attack):
	# Set animation to variable animation
	$PLAYER_Sprite.play(animation)
	
	# Check the state of the player animation; returns false if it's not attacking
	if state(animation) == false:
		# If the player is not moving, set the animation to "Idle", otherwise set it to run
		if vel == Vector2.ZERO:
			animation = "Idle"
		else:
			animation = "Run"
	
	# If it is attacking, wait for the animation to finish and then set the animation to idle
	if state(animation) == true:
		yield($PLAYER_Sprite, "animation_finished")
		animation = "Idle"
	
	# If the player inputs an attack, set the animation to attack 1
	if attack:
		animation = "Attack_1"

	# Flip sprite depending on what direction the player is facing
	if input.x == -1:
		$PLAYER_Sprite.flip_h = true
	if input.x == 1:
		$PLAYER_Sprite.flip_h = false

# Handles animation state; returns true if the attack animation is playing; false otherwise
func state(animation):
	if ($PLAYER_Sprite.animation == "Attack_1"):
		state = true
	else:
		state = false
	return state
