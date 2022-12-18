extends CharacterBody2D

signal player_start

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var started = false

func _physics_process(delta):
	velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.set_frame(0)
		$AnimatedSprite2D.play()
		velocity.y = JUMP_VELOCITY
		if not started:
			started = true
			emit_signal("player_start")

	velocity.x = SPEED
	
	if started:
		move_and_slide()
