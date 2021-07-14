extends TextureButton

onready var counter = 0
onready var player = get_parent().get_node("AnimationPlayer")

func _pressed():
	if get_node(".").name == "Button_2":
		$UI.play()
		player.play("Right")
	if get_node(".").name == "Button_1":
		$UI.play()
		player.play("Left")

func add():
	counter = counter + 1
	
func sub():
	counter = counter - 1
