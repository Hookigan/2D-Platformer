extends Control

@onready var audio = $Audio
var click_sfx : AudioStream = preload("res://Added_Sprites/Button Sound.wav")
var hover_sfx : AudioStream = preload("res://Added_Sprites/Hover.ogg")


func _on_play_button_pressed():
	audio.stream = click_sfx
	audio.play()
	await audio.finished
	PlayerStats.score = 0
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_quit_button_pressed():
	audio.stream = click_sfx
	audio.play()
	await audio.finished
	get_tree().quit()


func _on_play_button_mouse_entered() -> void:
	audio.stream = hover_sfx
	audio.play()


func _on_quit_button_mouse_entered() -> void:
	audio.stream = hover_sfx
	audio.play()
