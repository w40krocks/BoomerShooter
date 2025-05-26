extends Node
class_name StateMachine

@export var IntialState : State

var CurrentState : State
var States : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			States[child.name] = child
			child.Transitioned.connect(_StateTransition)
	
	if IntialState:
		IntialState.Enter()
		CurrentState = IntialState


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentState:
		CurrentState.Update(delta)
	
func _physics_process(delta: float) -> void:
	if CurrentState:
		CurrentState.PhysicsUpdate(delta)

func _StateTransition(state, NewStateName):
	if state != CurrentState:
		return
	
	var NewState = States.get(NewStateName)
	if not NewState:
		return
	
	if CurrentState:
		CurrentState.Exit()
	NewState.Enter()
	NewState.PreviousState = CurrentState
	CurrentState = NewState
