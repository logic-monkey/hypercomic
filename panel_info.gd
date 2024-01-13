@tool
extends HBoxContainer
@export_group("Panel Info", "pi_")
@export var pi_index:String:
	get:
		return %index.text
		notify_property_list_changed()
	set(value):
		if not is_node_ready(): await ready
		%index.text = value
		notify_property_list_changed()
@export var pi_name:String:
	get:
		return %name.text
		notify_property_list_changed()
	set(value):
		if not is_node_ready(): await ready
		%name.text = value
		notify_property_list_changed()
@export var pi_scene:String:
	get:
		return %scene.text
		notify_property_list_changed()
	set(value):
		if not is_node_ready(): await ready
		%scene.text = value
		notify_property_list_changed()
		
signal name_changed
func _on_name_text_changed():
	if %name.text.is_empty() or %name.text == "---":
		%nmlbl2.visible = false
		%scene.visible = false
	else:
		%nmlbl2.visible = true
		%scene.visible = true
	name_changed.emit()
		
func _ready():
	_on_name_text_changed()

signal scene_changed
func _on_scene_text_changed():
	scene_changed.emit()
	
signal move_up
func _on_up_button_down():
	move_up.emit()

signal move_down
func _on_down_button_down():
	move_down.emit()

signal remove
func _on_remove_pressed():
	remove.emit()
