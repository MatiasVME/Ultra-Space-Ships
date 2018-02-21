extends Node

onready var laser = $Laser
onready var hit_1 = $Hit1
onready var hit_2 = $Hit2
onready var ship_hit = $ShipHit
onready var logo_sound = $LogoSound
onready var menu_sound = $MenuSound

enum Sound {LASER, HIT_1, HIT_2, SHIP_HIT, LOGO_SOUND, MENU_SOUND}
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
		Sound.LOGO_SOUND:
			current_sound = logo_sound
		Sound.MENU_SOUND:
			current_sound = menu_sound
		
func play_sound():
	if current_sound != null:
		current_sound.play()
		
func stop_sound():
	if current_sound != null:
		current_sound.stop()