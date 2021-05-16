extends Control

var level = 0
onready var button_r = $Button_2
onready var button_l = $Button_1
onready var select = $Select

# Update text by getting the node and actively setting the text to the counter value
func _process(_delta):
	# Quirky modulus math that returns the index of the level
	level = abs(fmod(button_r.counter + button_l.counter, 4))
	if level == 0:
		ed(true, false)
	elif level == 3:
		ed(false, true)
	else:
		ed(false, false)

func _on_Select_pressed():
	get_tree().change_scene("res://scenes/gameplay_ph/demo.tscn")

# Function used to disable/enable the buttons
func ed(b1, b2):
	button_l.disabled = b1
	button_r.disabled = b2

