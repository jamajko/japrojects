extends KinematicBody2D

const speed = 500
const jump = -900
const gravity = 50
const up = Vector2(0, -1)

signal fall_damage()
signal win_level1()

var motion = Vector2()

func _physics_process(delta):
	motion.y += gravity
	motion.x = 0
	
	if Input.is_action_pressed("esc_key"):
		get_tree().change_scene("res://Scény/Menu.tscn")
	
	if Input.is_action_pressed("right_arr") && self.position.x < get_node("../Player2").position.x +960:
		motion.x += speed
		get_node("AnimatedSprite").animation = "walking"
		get_node("AnimatedSprite").flip_h = false
	elif Input.is_action_pressed("left_arr") && self.position.x > get_node("../Player2").position.x -960:
		motion.x -= speed
		get_node("AnimatedSprite").animation = "walking"
		get_node("AnimatedSprite").flip_h = true
	else:
		motion.x = 0
		get_node("AnimatedSprite").animation = "standing"
	
	if is_on_floor():
		if Input.is_action_just_pressed("up_arr"):
			motion.y = jump
	else:
		get_node("AnimatedSprite").animation = "jumping"
	
	#FallDamage
	if motion.y > 1800:
			emit_signal("fall_damage")
	
	motion = move_and_slide(motion, up)

func _on_Area2D_area_entered(area):
	emit_signal("win_level1")

