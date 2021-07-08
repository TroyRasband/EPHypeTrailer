extends TextureProgress

onready var player = get_parent().get_parent().get_node("YSort/PLAYER")
onready var enemy_spawn = get_parent().get_parent().get_node("Spawn_Enemy")

func _ready():
	self.max_value = enemy_spawn.max_kills
	self.value = player.kills
	
func _process(delta):
	update_bar()

func update_bar():
	self.value = player.kills
