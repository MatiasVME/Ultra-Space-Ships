extends Node

var is_win = false

func _ready():
	$CanvasLayer/ResultDisplay.text = "Level " + str(Main.current_level)
	$Anim.play_backwards("show")
	
	if Main.get_player() == null:
		Main.set_player($Player)

func _on_IsWin_timeout():
	if get_tree().get_nodes_in_group("Enemies").size() <= 0:
		$CanvasLayer/ResultDisplay.text = "You Win"
		
		$Anim.play("show")
		$IsWin.stop()
		is_win = true

func _on_Anim_animation_finished( anim_name ):
	if is_win and anim_name == "show":
		get_tree().change_scene("res://Game/Levels/Level1.tscn")
