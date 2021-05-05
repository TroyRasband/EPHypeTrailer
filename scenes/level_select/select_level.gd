extends Control

# Press space to change scene to selected level
func _input(_event):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://scenes/gameplay_ph/demo.tscn")
