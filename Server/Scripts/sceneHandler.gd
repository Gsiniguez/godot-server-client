extends Node


func instantiate_player(player_id):
	await get_tree().create_timer(2).timeout
	rpc("client_instantiate_player", player_id)

@rpc("any_peer", "reliable")
func client_instantiate_player(id):
	pass
