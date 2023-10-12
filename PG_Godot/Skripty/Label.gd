extends Label

var ms = 0
var s = 0
var m = 0

func _process(delta):

	if ms > 9:
		s+=1
		ms=0
		
	if s > 59:
		m+=1
		s=0
	
	set_text(str(m)+":"+str(s)+":"+str(ms))
	
	pass


func _on_Timer_timeout():
	ms += 1


func _on_Timer_end_timeout():
	get_tree().change_scene("res://Scény/Menu.tscn")
