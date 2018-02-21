extends Node

var is_win = false

var rec_player = load("res://Game/Actors/Player/Player.tscn")

func _ready():
	$CanvasLayer/ResultDisplay.text = "Level " + str(Main.current_level)
	$Anim.play_backwards("show")
	
	create_player()
	$HUD.update_life_board()
	
func _physics_process(delta):
	# Cuando pierde
	if Main.is_over and $Anim.assigned_animation != "is_over":
		reset_all()
		$Anim.play("is_over")
	
func create_player():
	Main.player_mark_to_dead = false
	
	var player = rec_player.instance()
	player.position = Vector2(Main.RES_X / 2, Main.RES_Y - 50)
	add_child(player)

	if Main.get_player() == null:
		Main.set_player($Player)

func reset_all(except_level = false):
	$HUD.update_life_board()
	Main.lifes = 3
	
	if not except_level:
		Main.current_level = 1

func _on_IsWin_timeout():
	if get_tree().get_nodes_in_group("Enemies").size() <= 0:
		$CanvasLayer/ResultDisplay.text = "You Win"
		
		$Anim.play("show")
		$IsWin.stop()
		is_win = true

func _on_Anim_animation_finished( anim_name ):
	if is_win and anim_name == "show":
		Main.enemies_can_fire = false
		Main.player_can_move = false
		Main.current_level += 1
		
		if Main.current_level > Main.LAST_LEVEL:
			reset_all(true)
			get_tree().change_scene("res://Game/MainScreens/Credits.tscn")
		
		get_tree().change_scene(str("res://Game/Levels/Level" + str(Main.current_level) + ".tscn"))
	elif anim_name == "show":
		Main.enemies_can_fire = true
		Main.player_can_move = true
	
	if anim_name == "is_over":
		get_tree().change_scene("res://Game/MainScreens/Menu.tscn")

func _on_IsDead_timeout():
	if Main.player_is_dead:
		create_player()
		$HUD.update_life_board()
