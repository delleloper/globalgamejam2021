extends Control

var finished = false
var finished2 = false


func _process(delta: float) -> void:
	if finished:
		if Input.is_action_just_pressed("action") && finished:
			$AnimationPlayer.play("controls")
		if Input.is_action_just_pressed("action") && finished2:
			$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "show":
		finished = true
	if anim_name == "controls":
		finished2 = true

func gotoGame():
	get_tree().change_scene("res://Space.tscn")
