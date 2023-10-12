extends Control

func _ready():
	get_tree().paused = false
	#$VBoxContainer/SpustitHru.grab_focus()
#Ovladanie menu so sipkami (focus robil problemy)

func _on_SpustitHru_pressed():
	get_tree().change_scene("res://Scény/Level1.tscn")


func _on_Monosti_pressed():
	get_tree().change_scene("res://Scény/Instructions.tscn")


func _on_VypnutHru_pressed():
	get_tree().quit()


