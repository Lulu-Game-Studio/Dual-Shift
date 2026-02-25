extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -500.0
var is_active = true
var lulu_nearby = false 

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

	if Input.is_action_just_pressed("Interact"):
		if lulu_nearby:
			transform_now()

func update_animations():
	if not is_on_floor():
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
		else:
			$AnimatedSprite2D.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func transform_now():
	if get_parent().has_node("Fusion"): 
		return
	
	var fusion = load("res://Scenes/fusion.tscn").instantiate()
	fusion.global_position = global_position 
	
	get_parent().add_child(fusion)
	var lulu = get_parent().find_child("Lulu", true, false)
	if lulu:
		lulu.queue_free()
	
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Lulu":
		lulu_nearby = true

func _on_area_2d_body_exited(body):
	if body.name == "Lulu":
		lulu_nearby = false
