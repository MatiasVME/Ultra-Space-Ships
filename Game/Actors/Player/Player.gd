extends KinematicBody2D

var direction = 0

var move_x = 0
var move_y = 0

var speed = 200

func _physics_process(delta):
	direction = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))

	if direction == 1 and not is_limited_right():
		move_x = speed * delta
	elif direction == -1 and not is_limited_left():
		move_x = -speed * delta
	else:
		move_x = 0
	
	if Input.is_action_pressed("ui_up") and not is_limited_up():
		move_y = -speed * delta
	elif Input.is_action_pressed("ui_down") and not is_limited_down():
		move_y = speed * delta
	else:
		move_y = 0

	move_and_collide(Vector2(move_x, move_y))
	
	print(global_position.y)
	
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