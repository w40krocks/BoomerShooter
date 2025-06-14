extends Node
class_name State

signal Transitioned ## Called when switching between states
var PreviousState : State

func Enter(): ##runs when the state is switched into
	pass

func Exit(): ##runs when the state is switched out of
	pass

func Update(_delta : float): ##runs every frame when state is active
	pass

func PhysicsUpdate(_delta : float): ##runs every frame when state is active
	pass
