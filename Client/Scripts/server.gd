extends Node

var network = ENetMultiplayerPeer.new()
var port = 3010
var ip = "127.0.0.1"

# Called when the node enters the scene tree for the first time.
func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	multiplayer.multiplayer_peer = network
	
	network.peer_disconnected.connect(_OnConnectionFailed)
	network.peer_connected.connect(_OnConnectionSucceded)

func _OnConnectionFailed(server_id):
	print("Failed to connect ", str(server_id))

func _OnConnectionSucceded(server_id):
	print("Succesfully connected ", str(server_id))
