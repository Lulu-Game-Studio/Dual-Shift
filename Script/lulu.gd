extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const FUSION_SCENE = preload("res://Scenes/fusion.tscn") 

var wilson_nearby = false 

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func interact():
	if wilson_nearby:
		transform_now()

func transform_now():
	var fusion = FUSION_SCENE.instantiate()
	fusion.global_position = global_position 
	get_parent().add_child(fusion)
	
	var wilson = get_parent().get_node("Wilson")
	if wilson: 
		wilson.queue_free()
	
	queue_free() 

func _on_area_2d_body_entered(body):
	if body.name == "Wilson":
		wilson_nearby = true

func _on_area_2d_body_exited(body):
	if body.name == "Wilson":
		wilson_nearby = false
