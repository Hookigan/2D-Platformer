extends Camera2D

@export var padding : float = 500.0
@export var min_zoom : float = 2.4
@export var max_zoom : float = 3
@export var zoom_speed : float = 2.0
@export var velocity_zoom_factor : float = 0.05

var players : Array = []

func _ready():
	players = get_tree().get_nodes_in_group("Player")

func _process(delta):
	if players.is_empty():
		return
	
	var mid = Vector2.ZERO
	for p in players:
		mid += p.global_position
	mid /= players.size()
	
	global_position = lerp(global_position, mid, 5.0 * delta)
	
	var dist = players[0].global_position.distance_to(players[1].global_position)
	
	var total_speed = 0.0
	for p in players:
		total_speed += p.velocity.length()
	
	var target_zoom = clamp(padding / (dist + padding), min_zoom, max_zoom)
	target_zoom -= total_speed * velocity_zoom_factor * 0.01
	target_zoom = clamp(target_zoom, min_zoom, max_zoom)
	
	zoom = lerp(zoom, Vector2(target_zoom, target_zoom), zoom_speed * delta)
