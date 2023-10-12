extends Node2D

func _ready():
	get_tree().paused = false

func _process(delta):
	if Input.is_action_pressed("esc_key"):
		get_tree().change_scene("res://Scény/Menu.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://Scény/Menu.tscn")
