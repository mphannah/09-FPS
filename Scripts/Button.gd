extends Interactable

func get_interaction_text():
	return "Press Button"
	
func interact():
	get_tree().change_scene("res://Scenes/YouWin.tscn")
