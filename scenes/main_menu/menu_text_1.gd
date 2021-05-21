extends Sprite

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(2)
	timer.start()
	
func _process(delta):
	if timer.get_time_left() < 1:
		self.visible = false
	
func _on_Timer_timeout():
	self.visible = true
	timer.stop()
	timer.set_wait_time(2)
	timer.start()
