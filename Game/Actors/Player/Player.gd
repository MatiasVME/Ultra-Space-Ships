extends KinematicBody2D

var rec_laser = load("res://Game/Actors/Bullets/Lasers/Laser.tscn")

var direction = 0

var move_x = 0
var move_y = 0

var speed = 200

func _ready():
	randomize()
	random_texture()
	Main.player_is_inmortal = true

func _physics_process(delta):
	if not Main.player_can_move:
		return
	
	direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	if direction == 1 and not is_limited_right():
		move_x = speed * delta
	elif direction == -1 and not is_limited_left():
		move_x = -speed * delta
	else:
		move_x = 0
	
	# TODO: Utilizar direction_y en ves de esto.
	if Input.is_action_pressed("ui_up") and not is_limited_up():
		move_y = -speed * delta
	elif Input.is_action_pressed("ui_down") and not is_limited_down():
		move_y = speed * delta
	else:
		move_y = 0
		
	if Input.is_action_just_pressed("ui_accept"):
		var laser = rec_laser.instance()
		laser.global_position.y = $Image.global_position.y - 40
		laser.global_position.x = $Image.global_position.x
		get_parent().add_child(laser)
		
		SoundManager.select_sound(0)
		SoundManager.play_sound()

	move_and_collide(Vector2(move_x, move_y))
	
func is_limited_right():
	if global_position.x > Main.RES_X - 50:
		return true
		
	return false
	
func is_limited_left():
	if global_position.x < 0 + 50:
		return true
		
	return false
	
func is_limited_up():
	if global_position.y < Main.RES_Y / 2 + 50:
		return true
	
	return false
	
func is_limited_down():
	if global_position.y > Main.RES_Y - 50:
		return true
	
	return false
	
func random_texture():
	var texture_num = int(rand_range(1, 13) - 0.001)
	var rec_texture = load(str("res://Game/Actors/Player/Players/Player", str(texture_num),".png"))
	$Image.texture = rec_texture

func _on_Anim_animation_finished( anim_name ):
	if anim_name == "dead":
		if Main.lifes > 1:
			get_parent().create_player()
			Main.player_can_move = true
			Main.lifes -= 1
			get_parent().get_node("HUD").update_life_board()
		else:
			Main.is_over = true
		
		queue_free()
	elif anim_name == "start":
		Main.player_is_inmortal = false
