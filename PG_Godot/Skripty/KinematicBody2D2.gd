extends KinematicBody2D

const speed = 500
const jump = -1400
const gravity = 50
const up = Vector2(0, -1)

var motion = Vector2()

func _physics_process(delta):
	motion.y += gravity
	motion.x = 0
	
	if Input.is_action_pressed("d_key") && self.position.x - 960 < get_node("../Player1").position.x:
		motion.x += speed
		get_node("AnimatedSprite").animation = "walking"
		get_node("AnimatedSprite").flip_h = false
	elif Input.is_action_pressed("a_key") && self.position.x + 960 > get_node("../Player1").position.x:
		motion.x -= speed
		get_node("AnimatedSprite").animation = "walking"
		get_node("AnimatedSprite").flip_h = true
	else:
		motion.x = 0
		get_node("AnimatedSprite").animation = "standing"
	
	if is_on_floor():
		if Input.is_action_just_pressed("w_key"):
			motion.y = jump
	else:
		get_node("AnimatedSprite").animation = "jumping"
	
	motion = move_and_slide(motion, up)
