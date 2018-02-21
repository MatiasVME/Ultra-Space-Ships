extends Node

func _on_Credits_pressed():
	get_tree().change_scene("res://Game/MainScreens/Credits.tscn")

func _on_Exit_pressed():
	get_tree().quit()
	
func _on_Start_pressed():
	Main.current_level = 1
	Main.player_is_dead = false
	Main.player_mark_to_dead = false
	Main.is_over = false
	get_tree().change_scene("res://Game/Levels/Level1.tscn")
