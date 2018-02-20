extends Node

onready var laser = $Laser
onready var hit_1 = $Hit1
onready var hit_2 = $Hit2
onready var ship_hit = $ShipHit

enum Sound {LASER, HIT_1, HIT_2, SHIP_HIT}
var current_sound = null

func select_sound(sound):
	match sound:
		Sound.LASER:
			current_sound = laser
		Sound.HIT_1:
			current_sound = hit_1
		Sound.HIT_2:
			current_sound = hit_2
		Sound.SHIP_HIT:
			current_sound = ship_hit
		
func play_sound():
	if current_sound != null:
		current_sound.play()
		
func stop_sound():
	if current_sound != null:
		current_sound.stop()