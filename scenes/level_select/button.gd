extends Button

onready var counter = 0

func _pressed():
	if get_node(".").name == "Button_2":
		counter = counter + 1
	if get_node(".").name == "Button_1":
		counter = counter - 1


