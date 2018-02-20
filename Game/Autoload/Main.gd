extends Node

const RES_X = 800
const RES_Y = 480

var current_level = 1

var player setget set_player, get_player

func set_player(_player):
	player = _player
	
func get_player():
	return player