extends Node

func _on_Credits_pressed():
	get_tree().change_scene("res://Game/MainScreens/Credits.tscn")

func _on_Exit_pressed():
	get_tree().quit()
	
func _on_Start_pressed():
	get_tree().change_scene("res://Game/Levels/Level1.tscn")
