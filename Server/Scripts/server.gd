extends Node


var network = ENetMultiplayerPeer.new()
var port = 3010
var max_players = 300


func _ready():
	StartServer()


func StartServer():
	network.create_server(port,max_players)
	multiplayer.multiplayer_peer = network
	print("Server started")
	
	network.peer_connected.connect(_Peer_Connected)
	network.peer_disconnected.connect(_Peer_Disconnected)


func _Peer_Connected(player_id):
	print("User " + str(player_id) + " connected")
	$SceneHandler.instantiate_player(player_id)
	await get_tree().create_timer(2).timeout
	Combat.rpc_id(player_id, "attack1", player_id)
	

func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " disconnected")


