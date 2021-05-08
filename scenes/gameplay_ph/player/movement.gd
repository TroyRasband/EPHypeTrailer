extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 200
var animation = "Idle"

# Handles physics processes including collision
func _physics_process(delta):
	var input = Vector2.ZERO
	
	# Returns the input values
	input.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	vel = input.normalized() * speed * 60 * delta
	vel = move_and_slide(vel)
	
	handle_sprite(input, vel)
	
func handle_sprite(input, vel):
	# Set animation to variable animation
	$PLAYER_Sprite.play(animation)
	
	# If the player is not moving, set the animation to "Idle", otherwise set it to run
	if vel == Vector2.ZERO:
		animation = "Idle"
	else:
		animation = "Run"
	
	# Flip sprite depending on what direction the player is facing
	if input.x == -1:
		$PLAYER_Sprite.flip_h = true
	if input.x == 1:
		$PLAYER_Sprite.flip_h = false
