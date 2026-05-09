extends StaticBody2D

@export var move_height : float = 300.0
@export var move_speed : float = 100.0
@export var require_both_players : bool = true

var players_on_platform : Array = []
var start_pos : Vector2
var moving : bool = false
var has_reached_top : bool = false

@onready var detection_area = $DetectionArea
@onready var col = $CollisionShape

func _ready():
	start_pos = global_position
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player") and not body in players_on_platform:
		players_on_platform.append(body)
		if require_both_players:
			if players_on_platform.size() >= 2:
				moving = true
		else:
			moving = true

func _on_body_exited(body):
	if body in players_on_platform:
		players_on_platform.erase(body)
		moving = false

func _physics_process(delta):
	if moving:
		global_position.y -= move_speed * delta
		if global_position.y <= start_pos.y - move_height:
			global_position.y = start_pos.y - move_height
			moving = false
			has_reached_top = true
			await get_tree().create_timer(2.0).timeout
			_disappear()

func _disappear():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	await tween.finished
	visible = false
	col.disabled = true
