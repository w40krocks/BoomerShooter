extends Node
class_name State

signal Transitioned ## Called when switching between states
var PreviousState : State

func Enter():
	pass

func Exit():
	pass

func Update(_delta : float):
	pass

func PhysicsUpdate(_delta : float):
	pass
