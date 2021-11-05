extends Control

var level = 0
onready var button_r = $Button_2
onready var button_l = $Button_1
onready var select = $Select

onready var levels = [load("res://scenes/gameplay_ph/backgrounds/forestlevel.png"),
			load("res://scenes/gameplay_ph/backgrounds/Airportlevel.png"),
			load("res://scenes/gameplay_ph/backgrounds/alien_level.png"),
			load("res://scenes/gameplay_ph/backgrounds/OfficeLevel.png")]

onready var player = get_node("AnimationPlayer")

func _ready():
	player.play("Fade")

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
	$Level_Display.set_texture(levels[level])

	if Input.is_action_pressed("ui_accept"):
		$READY.play()
		$Select.disabled = true
		$CanvasLayer/Scene_Transition.play("Transition")
		Level.level = level

func _on_Select_pressed():
	$READY.play()
	$Select.disabled = true
	$CanvasLayer/Scene_Transition.play("Transition")
	Level.level = level
	


# Function used to disable/enable the buttons
func ed(b1, b2):
	button_l.disabled = b1
	button_r.disabled = b2

func _on_Scene_Transition_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/gameplay_ph/demo.tscn")
