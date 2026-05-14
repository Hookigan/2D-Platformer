extends CharacterBody2D

@onready var player = $"../Player"
@onready var Player = $"../Player"

func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	look_at(Player.global_position)
