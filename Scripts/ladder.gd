extends Area2D

@export var top_limit : float = -4.0
@export var bottom_limit : float = 300.0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.on_ladder = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.on_ladder = false

func _process(_delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("Player") and body.on_ladder:
			# Lock to ladder X
			body.global_position.x = global_position.x
			# Clamp Y between top and bottom of ladder
			body.global_position.y = clamp(
				body.global_position.y,
				top_limit,
				bottom_limit
			)
