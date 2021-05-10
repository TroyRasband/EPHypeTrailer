extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 200
var animation = "Idle"
var attack
var state = true
var prev_attack = "Attack_3"

onready var player = $AnimationPlayer

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
		$PLAYER_Sprite.flip_h = true
		$BoxPivot.scale.x = -1
	if input.x == 1:
		$PLAYER_Sprite.flip_h = false
		$BoxPivot.scale.x = 1

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
		if (prev_attack == "Attack_3"):
			animation = "Attack_1"
			swap()
			return
		if (prev_attack == "Attack_1"):
			animation = "Attack_2"
			swap()
			return
		if (prev_attack == "Attack_2"):
			animation = "Attack_3"
			swap()
			return

# Changes prev_animation to current animation
func swap():
	prev_attack = animation

# Resets animation to Idle
func reset():
	animation = "Idle"

# Check if hitbox connects with hurtbox
func _on_Hitbox_area_entered(area):
	if (area.is_in_group("Hurtbox")):
		area.get_hurt()
