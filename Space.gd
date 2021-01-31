extends Node2D

onready var audioPlayer = $AudioStreamPlayer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().reload_current_scene()



func _on_AudioStreamPlayer_finished() -> void:
	audioPlayer.stream = preload("res://Assets/Sounds/loop.wav")
	audioPlayer.play()
