extends Node2D

onready var player = get_node("YSort/PLAYER")

func _ready():
	$CanvasLayer/Fade_in/AnimationPlayer.play("fade_in")

func _process(delta):
	if (player.health <= 0):
		$CanvasLayer/Flash/AnimationPlayer.play("flash")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/game_over/game_over.tscn")
