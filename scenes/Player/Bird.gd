extends CharacterBody2D

signal player_start
signal player_die
signal player_point


const SPEED = 128.0
const JUMP_VELOCITY = -256.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var started = false

func _physics_process(delta):
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("flap"):
		if not started:
			started = true
			emit_signal("player_start")
		flap()

	velocity.x = SPEED

	if started:
		if velocity.y > JUMP_VELOCITY * 0.5:
			$AnimatedSprite2D.rotation = lerp_angle(
				$AnimatedSprite2D.rotation, 
				$DownPosition.position.normalized().angle(), 
			0.1)
		var collision = move_and_collide(velocity * delta)
		if collision:
			verify_if_point_or_die(collision)

func flap():
	$AnimatedSprite2D.set_frame(0)
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.look_at($UpPosition.global_position)
	velocity.y = JUMP_VELOCITY



func verify_if_point_or_die(collision: KinematicCollision2D):
	var collider = collision.get_collider()
	if collider.is_in_group("point"):
		emit_signal("player_point")
		collider.free()
		return 
	if collider.is_in_group("obstacle"):
		emit_signal("player_die")
	
