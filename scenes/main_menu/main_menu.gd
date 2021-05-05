extends Control

# Press space to change scene to level select
func _input(_event):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://scenes/level_select/level_select.tscn")
