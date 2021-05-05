extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 200

# Handles physics processes including collision
func _physics_process(delta):
	var input = Vector2.ZERO
	
	# Returns the input values
	input.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	vel = input.normalized() * speed * 60 * delta
	
	vel = move_and_slide(vel)
