@tool
extends EditorPlugin

const NAME = "_PANELS"
var dock

func _enter_tree():
	#dock  = preload("res://addons/hypercomic/panels_docker.tscn").instantiate()
	#add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, dock)
	add_autoload_singleton(NAME, "panels.gd")
	pass

func _exit_tree():
	remove_autoload_singleton(NAME)
	#remove_control_from_docks(dock)
	#dock.free()
	pass
