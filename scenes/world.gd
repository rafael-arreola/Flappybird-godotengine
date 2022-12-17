extends Node2D

func _on_bird_player_start():
	$Message.hide()


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		Input.action_press("flap")
