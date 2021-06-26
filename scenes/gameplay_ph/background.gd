extends TextureRect

onready var levels = [load("res://scenes/gameplay_ph/backgrounds/forestlevel.png"),
			load("res://scenes/gameplay_ph/backgrounds/Airportlevel.png"),
			load("res://scenes/gameplay_ph/backgrounds/alien_level.png"),
			load("res://scenes/gameplay_ph/backgrounds/OfficeLevel.png")]

func _ready():
	if (Level.level < 4):
		set_texture(levels[Level.level])
