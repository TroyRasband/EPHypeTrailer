extends Node2D

onready var player = get_node("YSort/PLAYER")
onready var victory_anim_done = 0

func _ready():
	Level.complete = 0
	$CanvasLayer/Fade_in/AnimationPlayer.play("fade_in")

func _process(delta):
	if (player.health <= 0):
		$CanvasLayer/Flash/AnimationPlayer.play("flash")
	if (Level.complete == 1):
		$CanvasLayer/Victory_Screen/AnimationPlayer_Victory.play("Victory_Screen")
	if (Level.complete == 1) && (victory_anim_done):
		$CanvasLayer/Victory_Screen/AnimationPlayer_Victory.stop()

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/game_over/game_over.tscn")

func _on_AnimationPlayer_Victory_animation_finished(anim_name):
	victory_anim_done = 1
