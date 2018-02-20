extends RigidBody2D

func _ready():
	apply_impulse(Vector2(0,0), Vector2(0, -600))

func _on_Live_timeout():
	$Anim.play("dead")

func _on_VisibilityNotifier2D_screen_entered():
	$Anim.play("start")

func _on_Anim_animation_finished( anim_name ):
	if anim_name == "dead":
		queue_free()
