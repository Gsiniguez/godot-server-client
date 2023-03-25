extends Node


@rpc("any_peer")
func attack1(id):
	print("SERVER " + str(id) + " ATTACK")
