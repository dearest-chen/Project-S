class_name CardStateMachine
extends Node

@export var InitialState: CardState
var CurrentState: CardState
var State:={}

func init(card: CardUI) -> void:
	for child: CardState in get_children():
		if child:
			State[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
	
	if InitialState:
		InitialState.enter()
		CurrentState = InitialState

				
func on_input (event:InputEvent)-> void:
	if CurrentState:
		CurrentState.on_input(event)
		
func on_gui_input (event:InputEvent)-> void:
	if CurrentState:
		CurrentState.on_gui_input(event)
		
func on_mouse_entered ()-> void:
	if CurrentState:
		CurrentState.on_mouse_entered()
		
func on_mouse_exited ()-> void:
	if CurrentState:
		CurrentState.on_mouse_exited()
		
func _on_transition_requested(from: CardState, to: CardState.State) -> void:
	if from != CurrentState:
		return
		
	var NewState: CardState = State[to]
	if not NewState:
		return
	
	if CurrentState:
		CurrentState.exit()
	
	NewState.enter()
	CurrentState = NewState
