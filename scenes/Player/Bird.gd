extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	velocity.y += gravity * delta

	# Handle flap.
	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.set_frame(0)
		$AnimatedSprite2D.play()
		velocity.y = JUMP_VELOCITY

	var direction = 0.5
	velocity.x = direction * SPEED
	
	move_and_slide()
