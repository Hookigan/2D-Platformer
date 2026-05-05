extends Camera2D

@export var zoom_level : float = 2.0

func _ready():
	make_current()
	zoom = Vector2(zoom_level, zoom_level)
