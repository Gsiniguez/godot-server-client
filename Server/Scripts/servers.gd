extends Node
signal logPlayers

var network = ENetMultiplayerPeer.new()
var port = 3010
var max_players = 300


var players = {}
var rooms = {}

func _ready():
	pass

func _log_players():
	var _timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_on_log_players)
	_timer.set_wait_time(2.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
func _on_log_players():
	print("PLAYERS ", players)

func _on_log_rooms():
	print("ROOMS ", rooms)
func _log_rooms():
	var _timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(_on_log_rooms)
	_timer.set_wait_time(2.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func StartServer():
	network.create_server(port,max_players)
	multiplayer.multiplayer_peer = network
	print("Server started")
	_log_players()
	_log_rooms()
	
	network.peer_connected.connect(_Peer_Connected)
	network.peer_disconnected.connect(_Peer_Disconnected)

func _Peer_Connected(player_id):
	print("User " + str(player_id) + " connected")
	players[str(player_id)] = {
		"id":str(player_id)
	}

func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " disconnected")
	players[str(player_id)] = null


func StartClient():
	network.create_client("127.0.0.1", port)
	multiplayer.multiplayer_peer = network
	
	network.peer_disconnected.connect(_OnConnectionFailed)
	network.peer_connected.connect(_OnConnectionSucceded)

func _OnConnectionFailed(server_id):
	print("Failed to connect ", str(server_id))

signal _on_client_connected_successfully
func _OnConnectionSucceded(server_id):
	print("Succesfully connected ", str(server_id))
	_on_client_connected_successfully.emit(str(server_id))


func CreateRoom():
	var roomNetwork = ENetMultiplayerPeer.new()
	roomNetwork.create_server(3011,max_players)
	rooms["3011"]= {"net":roomNetwork}
	print("Room started")
	roomNetwork.peer_disconnected.connect(_Peer_Disconnected_Room)
	roomNetwork.peer_connected.connect(_Peer_Connected_Room)

func _Peer_Connected_Room(player_id):
	print("User " + str(player_id) + " connected to room")
	rooms["3011"]["players"] += str(player_id)

func _Peer_Disconnected_Room(player_id):
	print("User " + str(player_id) + " disconnected from room")
	rooms[str(player_id)] = null

func ConnectRoom():
	var roomNetwork = ENetMultiplayerPeer.new()
	roomNetwork.create_client("127.0.0.1", 3011)
	roomNetwork.peer_disconnected.connect(_OnConnectionRoomFailed)
	roomNetwork.peer_connected.connect(_OnConnectionRoomSucceded)

func _OnConnectionRoomFailed(server_id):
	print("Failed to connect room ", str(server_id))

func _OnConnectionRoomSucceded(server_id):
	print("Succesfully connected room ", str(server_id))

