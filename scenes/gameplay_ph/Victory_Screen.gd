extends ColorRect

func _on_Quit_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/main_menu/main_menu.tscn")

func _on_Continue_Button_pressed():
	if (Level.level != 4):
		Level.level = Level.level + 1
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/gameplay_ph/demo.tscn")
	if (Level.level == 4):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/credits/credits.tscn")
