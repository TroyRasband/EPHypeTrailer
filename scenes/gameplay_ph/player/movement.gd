extends KinematicBody2D

# Create a velocity zero vector <0,0>
var vel = Vector2.ZERO
var speed = 200

# Gets input
func get_input():
	vel = Vector2.ZERO
	
	# Returns the input values
	vel.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	vel.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	
	vel = vel * speed
	
# Handles physics processes including collision
func _physics_process(delta):
	get_input()
	vel = move_and_slide(vel)
