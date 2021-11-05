extends Control

func _ready():
	$ColorRect/AnimationPlayer.play("fade_out")


func _on_TouchScreenButton_pressed():
	get_tree().change_scene("res://scenes/level_select/level_select.tscn")
	pass # Replace with function body.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/level_select/level_select.tscn")
		pass
