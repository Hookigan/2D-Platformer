extends Area2D

@onready var blacked_out = $"../BlackedOut"
@onready var dialogue_text = $"../DialogueUI/DialogueBox/DialogueText"
@onready var dialogue_box = $"../DialogueUI/DialogueBox"
@onready var speaker_label = $"../DialogueUI/DialogueBox/SpeakerLabel"
@onready var continue_label = $"../DialogueUI/DialogueBox/ContinueLabel"

var players_inside : Array = []
var dialogue_triggered : bool = false
var current_line : int = 0
var dialogue_lines = [
	{"speaker": "Pluh", "text": "Where do we go now?"},
	{"speaker": "Sprig", "text": "Let's look around for now-"},
]

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	dialogue_box.visible = false

func _on_body_entered(body):
	if body.is_in_group("Player") and not body in players_inside:
		players_inside.append(body)
		if players_inside.size() >= 2 and not dialogue_triggered:
			dialogue_triggered = true
			start_dialogue()

func _on_body_exited(body):
	if body in players_inside:
		players_inside.erase(body)

func start_dialogue():
	dialogue_box.visible = true
	show_line()
	for p in get_tree().get_nodes_in_group("Player"):
		p.freeze()

func show_line():
	speaker_label.text = dialogue_lines[current_line]["speaker"]
	dialogue_text.text = dialogue_lines[current_line]["text"]
	continue_label.visible = true

func _process(_delta):
	if dialogue_box.visible and Input.is_action_just_pressed("interact"):
		current_line += 1
		if current_line < dialogue_lines.size():
			show_line()
		else:
			finish_dialogue()

func finish_dialogue():
	dialogue_box.visible = false
	continue_label.visible = false
	for p in get_tree().get_nodes_in_group("Player"):
		p.unfreeze()
	var tween = create_tween()
	tween.tween_property(blacked_out, "modulate:a", 0.0, 1.5)
