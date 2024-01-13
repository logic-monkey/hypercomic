@tool
extends Node

@export var index : Array[String]
@export var panel : Dictionary
@export var start : String

func _ready():
	if Engine.is_editor_hint(): return
	var bb = load("res://blackboard.tres")
	if not bb: return
	if not "panels" in bb: return
	panel = bb.panels
	if not "start_panel" in bb: return
	start = bb.start_panel
