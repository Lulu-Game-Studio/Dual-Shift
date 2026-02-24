extends CharacterBody2D

const SPEED = 200.0 
const JUMP_VELOCITY = -350.0
const WILSON_SCENE = preload("res://Scenes/wilson.tscn")
const LULU_SCENE = preload("res://Scenes/Lulu.tscn")

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D2.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		separate()

func separate():
	var wilson = WILSON_SCENE.instantiate()
	var lulu = LULU_SCENE.instantiate()
	
	lulu.global_position = global_position
	wilson.global_position = global_position + Vector2(-20, -10) 

	get_parent().add_child(lulu)
	get_parent().add_child(wilson)

	queue_free()
