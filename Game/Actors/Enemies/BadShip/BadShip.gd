extends RigidBody2D

var mark_to_dead = false
var life

var limit_right
var limit_left

var spawn_y

var velocity_x = 0.5
var velocity_y = 0.5
var velocity_increment_x = 1
var velocity_increment_y = 1

enum MovementX {LEFT, RIGHT}
var current_movement_x = MovementX.LEFT
enum MovementY {UP, DOWN}
var current_movement_y

var first_impulse = true

func _ready():
	spawn_y = global_position.y
	
	limit_right = $LimitRight.global_position.x
	limit_left = $LimitLeft.global_position.x
	
	randomize()
	life = int(rand_range(1, 4) - 0.01)
	
	random_texture()
	
func _physics_process(delta):
	if linear_velocity.x > 5 or linear_velocity.x < -5:
		velocity_increment_x += 0.01
	else:
		velocity_increment_x = 1
	
	if not is_limit_left() and current_movement_x == MovementX.LEFT:
		if linear_velocity.x < 10:
			apply_impulse(Vector2(0, 0), Vector2(-velocity_x * velocity_increment_x, 0))
			
			if first_impulse:
				apply_impulse(Vector2(0, 0), Vector2(-velocity_x * 100, 0))
				first_impulse = false
	elif not is_limit_right() and current_movement_x == MovementX.RIGHT:
		apply_impulse(Vector2(0, 0), Vector2(velocity_x  * velocity_increment_x, 0))
	
	if is_limit_up() and current_movement_y == MovementY.UP:
		if linear_velocity.y > 10:
			apply_impulse(Vector2(0, 0), Vector2(0, -velocity_y * velocity_increment_y))
	elif is_limit_down() and current_movement_y == MovementY.UP:
		apply_impulse(Vector2(0, 0), Vector2(0, velocity_y * velocity_increment_y))
	
func is_limit_left():
	if global_position.x <= limit_left:
		current_movement_x = MovementX.RIGHT
		apply_impulse(Vector2(0, 0), Vector2(25, 0))
		
		return true
		
	return false
	
func is_limit_right():
	if global_position.x >= limit_right:
		current_movement_x = MovementX.LEFT
		apply_impulse(Vector2(0, 0), Vector2(-400, 0))

		return true
		
	return false
	
func is_limit_up():
	if global_position.y <= spawn_y - 40:
		current_movement_y = MovementY.DOWN
		apply_impulse(Vector2(0, 0), Vector2(0, 100))
		return true
		
	return false

func is_limit_down():
	if global_position.y >= spawn_y + 40:
		current_movement_y = MovementY.UP
		apply_impulse(Vector2(0, 0), Vector2(0, -100))
		return true
		
	return false
	
func random_texture():
	var texture_num = int(rand_range(1, 5) - 0.001)
	var rec_texture = load(str("res://Game/Actors/Enemies/BadShip/BadShip-Skin-", str(texture_num),".png"))
	$Image.texture = rec_texture

func _on_BadShip_body_entered( body ):
	if body.is_in_group("Bullet"):
		$Anim.play("damage")
		life -= 1
		
		if life <= 0 and $Anim.assigned_animation != "dead":
			mark_to_dead = true
			$TimeToDead.start()
			$Anim.play("dead")

func _on_VisibilityNotifier2D_screen_entered():
	$Anim.play("show")

func _on_TimeToDead_timeout():
	queue_free()
