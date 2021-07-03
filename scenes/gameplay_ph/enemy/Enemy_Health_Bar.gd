extends TextureProgress

onready var enemy = get_parent()

func _ready():
	self.max_value = 6
	self.value = enemy.health

func _process(delta):
	self.value = enemy.health
	if (enemy.health <= 0) || (Level.complete == 1):
		self.visible = false
