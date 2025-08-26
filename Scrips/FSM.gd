extends Node
class_name State

signal Transition(state, new_state_name)

@export var animation_tree: AnimationTree
@export var entity: CharacterBody2D
@export var can_move: bool

func Enter():
	pass

func Update(_delta: float):
	pass
	
func Physics_update(_delta: float):
	pass

func Exit():
	pass
