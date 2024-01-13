@tool
extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_popup()
	%start_panel_menu.get_popup().index_pressed.connect(_popup_index_pressed)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh_popup():
	var p = %start_panel_menu.get_popup() as PopupMenu
	p.clear()
	p.add_item("[null]")
	
	for item_name in _PANELS.index:
		if item_name == "---": 
			p.add_separator()
			continue
		if item_name.is_empty(): continue
		p.add_item(item_name)
		
func _popup_index_pressed(id:int):
	%start_panel_menu.text = %start_panel_menu.get_popup().get_text(id)


func _on_add_item_pressed():
	var pi = preload("panel_info.tscn")
	var item = pi.instantiate()
	%item_list.add_child(item)
	item.pi_index = "%s" % (%item_list.get_child_count()-1)
	
func _on_item_remove(id:int):
	pass
