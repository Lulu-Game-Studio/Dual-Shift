extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var is_active = true
var wilson_nearby = false 

@export var push_force = 500.0 

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_active:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("Move Left", "Move Right")
		if direction:
			velocity.x = direction * SPEED
			$AnimatedSprite2D.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()
	
	update_animations()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is RigidBody2D:
			if body.freeze:
				body.freeze = false
			body.apply_central_impulse(collision.get_normal() * -push_force)
	
	if Input.is_action_just_pressed("Interact"):
		if wilson_nearby:
			transform_now()

func update_animations():
	if not is_on_floor():
		$AnimatedSprite2D.play("JumpSprite")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")

func transform_now():
	if get_parent().has_node("Fusion"): 
		return

	var fusion = load("res://Scenes/fusion.tscn").instantiate()
	fusion.global_position = global_position 
	
	get_parent().add_child(fusion)
	var wilson = get_tree().get_first_node_in_group("Wilson")
	if wilson:
		wilson.queue_free()
	
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Wilson":
		wilson_nearby = true

func _on_area_2d_body_exited(body):
	if body.name == "Wilson":
		wilson_nearby = false
