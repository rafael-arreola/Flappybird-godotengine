extends Node2D

var MIN_Y_PIPES = 152.0
var MAX_Y_PIPES = 360.0

@export var pipes: PackedScene

var died = false
var points = 0
func _on_bird_player_start():
	if died:
		get_tree().reload_current_scene()
	else:
		$Camera2D/Messages/StartGame.hide()
		$Pipes/PipesSpawner.start()
		_on_pipes_spawner_timeout()


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		Input.action_press("flap")


func _on_pipes_spawner_timeout():
	var obstacle = pipes.instantiate()
	var y_position = randf_range(MIN_Y_PIPES, MAX_Y_PIPES)
	
	obstacle.position = Vector2($Bird.position.x + 250, y_position)
	$Pipes.add_child(obstacle)


func _on_bird_player_die():
	$Pipes/PipesSpawner.stop()
	$Camera2D/Messages/GameOver.show()
	died = true
	
func _on_bird_player_point():
	points += 1
	$Camera2D/Messages/Points.text = str(points)

func _physics_process(delta):
	$Camera2D.position.x = $Bird.position.x
