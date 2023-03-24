extends Node

@onready var map = $Map
const Player_Drunker = preload("res://Player/Drunker/player_drunker.tscn")

@rpc("any_peer", "reliable")
func client_instantiate_player(id):
	print("INSTATIATING PLAYER")
	var player = Player_Drunker.instantiate()
	player.name = str(id)
	map.add_child(player)
