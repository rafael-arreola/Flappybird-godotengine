extends CharacterBody2D

signal player_start

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var started = false

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if velocity.y > SPEED * 2:
		velocity.y = SPEED * 2
		
	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.set_frame(0)
		$AnimatedSprite2D.play()
		velocity.y = JUMP_VELOCITY
		if not started:
			started = true
			emit_signal("player_start")

	var direction = 0.5
	velocity.x = direction * SPEED
	
	if started:
		move_and_slide()
