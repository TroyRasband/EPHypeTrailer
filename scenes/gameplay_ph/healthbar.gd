extends TextureProgress

onready var player = get_parent().get_parent().get_node("YSort/PLAYER")

func _ready():
	self.max_value = player.health
	self.value = player.health

func _process(delta):
	update_health()

func update_health():
	self.value = player.health - 1
