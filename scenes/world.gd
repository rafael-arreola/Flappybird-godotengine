extends Node2D

var MIN_Y_PIPES = 152.0
var MAX_Y_PIPES = 360.0

@export var pipes: PackedScene

func _on_bird_player_start():
	$Message.hide()
	$Pipes/PipesSpawner.start()
	_on_pipes_spawner_timeout()


func _unhandled_input(event):
	print(event)
	if event is InputEventScreenTouch:
		Input.action_press("flap")


func _on_pipes_spawner_timeout():
	var obstacle = pipes.instantiate()
	var y_position = randf_range(MIN_Y_PIPES, MAX_Y_PIPES)
	
	obstacle.position = Vector2($Bird.position.x + 250, y_position)
	$Pipes.add_child(obstacle)
