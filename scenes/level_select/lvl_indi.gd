extends RichTextLabel

var level = 0
onready var button_r = get_parent().get_node("Button_2")
onready var button_l = get_parent().get_node("Button_1")

# Update text by getting the node and actively setting the text to the counter value
func _process(_delta):
	# Quirky modulus math that returns the index of the level
	level = abs(fmod(button_r.counter + button_l.counter, 4))
	get_node(".").text = str(level)
