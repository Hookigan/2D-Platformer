extends Node2D

var is_tied : bool = true
var p1_nearby : bool = false

@onready var climb_area = $ClimbArea
@onready var knot_area = $KnotArea

func _ready():
	climb_area.monitoring = false
	knot_area.body_entered.connect(_on_knot_entered)
	knot_area.body_exited.connect(_on_knot_exited)
	climb_area.body_entered.connect(_on_climb_entered)
	climb_area.body_exited.connect(_on_climb_exited)

func _process(_delta):
	if p1_nearby and Input.is_action_just_pressed("interact") and is_tied:
		untie()

func _on_knot_entered(body):
	if body.is_in_group("Player") and body.input_left == "move_left":
		p1_nearby = true

func _on_knot_exited(body):
	if body.is_in_group("Player") and body.input_left == "move_left":
		p1_nearby = false

func _on_climb_entered(body):
	if body.is_in_group("Player"):
		body.on_ladder = true

func _on_climb_exited(body):
	if body.is_in_group("Player"):
		body.on_ladder = false

func untie():
	is_tied = false
	climb_area.monitoring = true
	print("Rope untied!")
