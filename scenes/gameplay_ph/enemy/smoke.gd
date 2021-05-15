extends Sprite

onready var player = get_parent().get_node("Smoke_Player")

func _ready():
	player.play("Smoke")

func _on_Smoke_Player_animation_finished():
	player.stop()
