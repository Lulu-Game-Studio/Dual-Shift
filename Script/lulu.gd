extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump - Usamos tu acción "jump"
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement - Usamos tus acciones "Move Left" y "Move Right"
	var direction = Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
