extends Area2D

@onready var platform = $"../Platform"
@onready var lever_anim = $AnimatedSprite2D
var p2_nearby : bool = false
var activated : bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	lever_anim.play("idle")

func _on_body_entered(body):
	if body.name == "Player2":
		p2_nearby = true

func _on_body_exited(body):
	if body.name == "Player2":
		p2_nearby = false

func _process(_delta):
	if p2_nearby and not activated and Input.is_action_just_pressed("interact_p2"):
		activated = true
		lever_anim.play("pull")
		await lever_anim.animation_finished
		platform.visible = true
		platform.get_node("CollisionShape2D").disabled = false
