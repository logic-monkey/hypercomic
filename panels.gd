@tool
extends Node

@export var index : Array[HC_PanelEntry]
@export var panel : Dictionary
@export var start : String

func _ready():
	if Engine.is_editor_hint(): return
	var bb = load("res://blackboard.tres")
	if not bb: return
	if not "panels" in bb: return
	for p in bb.panels:
		var pan = p as HC_PanelEntry
		if not pan: continue
		index.append(pan)
		panel[pan.panel_name] = pan.panel
	if not "panel_start" in bb: return
	start = bb.panel_start
	
var current_panel: String = ""
func GoToPanel(panel_name:String):
	if not panel_name in panel:
		var c = current_panel
		if c.is_empty(): c = "[no current panel]"
		print("Panel \"%s\" does not exist.\nCalled from \"%s\"" % [panel_name, c])
		return
	if panel_name == current_panel: return
	if not "_history" in _SAVE.data:
		_SAVE.data["_history"] = []
	_SAVE.data._history.append(["goto", panel_name])
	current_panel = panel_name
	_FADE.FadeTo(panel[panel_name])
	
func RegisterChange(variable:String, to, from = null):
	if not "_history" in _SAVE.data:
		_SAVE.data["_history"] = []
	if variable == "_history":
		print("Please don't overwrite the history.")
		return
	if not from and variable in _SAVE.data:
		from = _SAVE.data[variable]
	_SAVE.data[variable] = to
	_SAVE.data._history.append(["change", variable, from, to])

func Rewind():
	if not "_history" in _SAVE.data or _SAVE.data._history.size() == 0:
		print("Tried to rewind, but there was nothing.")
		return
	var last_command = _SAVE.data._history.pop_back()

	while last_command != null and last_command[0] != "goto":
		if last_command[0] == "change":
			_SAVE.data[last_command[1]] = last_command[2]
		last_command = _SAVE.data._history.pop_back()
	if last_command != null: 
		current_panel = last_command[1]
	#_FADE.FadeTo(panel[current_panel])
	last_command = _SAVE.data._history.pop_back()
	while last_command != null and last_command[0] != "goto":
		if last_command[0] == "change":
			_SAVE.data[last_command[1]] = last_command[2]
		last_command = _SAVE.data._history.pop_back()
	if last_command != null: 
		current_panel = last_command[1]
		_SAVE.data._history.append(last_command)
	_FADE.FadeTo(panel[current_panel])
	
func Start():
	_SAVE.clear()
	GoToPanel(start)
	
func HasBeenTo(panel_name)->bool:
	if not "_history" in _SAVE.data: return false
	for histereon in _SAVE.data._history:
		if not histereon is Array: continue
		if not histereon[0]=="goto": continue
		if histereon[1] == panel_name: return true
	return false
	
