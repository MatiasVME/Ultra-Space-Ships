extends Node

const RES_X = 800
const RES_Y = 480

const LAST_LEVEL = 18

var music_enable = true
var sound_enable = true

var is_over = false
var current_level = 1
var score = 0

var enemies_can_fire = false
var player_can_move = false
var player_is_dead = false
var player_mark_to_dead = false
var player_is_inmortal = true
var lifes = 3

var update_life_board = false

var player setget set_player, get_player

func _ready():
	pass

func set_player(_player):
	player = _player
	
func get_player():
	return player