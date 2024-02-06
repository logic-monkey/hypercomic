@tool
extends Polygon2D
class_name SpeechBubble2D

@export var outline_color : Color = Color.BLACK
@export var outline_width : float = 2

func _ready():
	if Engine.is_editor_hint(): return
	var line = Line2D.new()
	line.antialiased = antialiased
	line.width = outline_width * 2
	line.points = polygon
	line.z_index = -1
	line.closed = true
	line.default_color = outline_color
	add_child(line)

func _draw():
	if not Engine.is_editor_hint(): return
	draw_polyline(polygon,outline_color,outline_width, antialiased)
