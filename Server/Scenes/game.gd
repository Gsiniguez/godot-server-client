extends Node

@onready var v_box_container = $UI/Panel/MarginContainer/VBoxContainer
@onready var v_box_host = $UI/Panel/MarginContainer/VBoxHost
@onready var v_box_client = $UI/Panel/MarginContainer/VBoxClient

# Called when the node enters the scene tree for the first time.
func _ready():
	Servers._on_client_connected_successfully.connect(_on_client_connected_successfully)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_host_pressed():
	Servers.StartServer()
	v_box_container.hide()
	v_box_host.show()

func _on_create_room_pressed():
	Servers.CreateRoom()
	pass # Replace with function body.


func _on_connect_pressed():
	Servers.StartClient()
	
func _on_client_connected_successfully(id):
	print(id)
	v_box_container.hide()
	v_box_client.show()

func _on_join_room_pressed():
	print("CONECCTING TO ROOM")
	Servers.ConnectRoom()
