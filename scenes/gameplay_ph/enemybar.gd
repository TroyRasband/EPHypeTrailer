extends TextureProgress

onready var player = get_parent().get_parent().get_node("YSort/PLAYER")

func _ready():
	self.max_value = 15
	self.value = player.kills
	
func _process(delta):
	update_bar()

func update_bar():
	self.value = player.kills
