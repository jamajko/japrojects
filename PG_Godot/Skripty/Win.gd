extends Node2D

func _process(delta):
	if Input.is_action_pressed("esc_key"):
		get_tree().change_scene("res://Scény/Menu.tscn")

func _on_Player1_win_level1():
	self.visible = true
	get_tree().paused = true

func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scény/Menu.tscn")

func _on_ReplayButton_pressed():
	get_tree().change_scene("res://Scény/Level1.tscn")



