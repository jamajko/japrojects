extends Camera2D

func _process(delta):
	self.position.x = get_node("../Player2").position.x

func _ready():
	get_tree().paused = false
