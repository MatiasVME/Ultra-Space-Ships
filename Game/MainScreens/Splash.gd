extends Node

func _ready():
	pass

func _on_ToMenu_timeout():
	get_tree().change_scene("res://Game/MainScreens/Menu.tscn")
