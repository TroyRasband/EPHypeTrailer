extends TextureProgress

onready var boss = get_parent()

func _ready():
	self.max_value = 30
	self.value = boss.health

func _process(delta):
	self.value = boss.health
	if (boss.health <= 0) || (Level.complete == 1):
		self.visible = false

