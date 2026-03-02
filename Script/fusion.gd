extends CharacterBody2D

const SPEED = 250.0 
const JUMP_VELOCITY = -500.0
var starting_position : Vector2 

func _ready():
	starting_position = global_position 

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Move Left", "Move Right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("Interact"):
		separate()

func separate():
	var wilson_inst=load("res://Scenes/wilson.tscn").instantiate()
	var lulu_inst=load("res://Scenes/lulu.tscn").instantiate()
	
	lulu_inst.global_position = global_position
	wilson_inst.global_position = global_position + Vector2(-35, -20) 
	
	lulu_inst.is_active = true
	wilson_inst.is_active = false
	
	lulu_inst.modulate.a = 1.0
	wilson_inst.modulate.a= 0.5
	
	var mundo=get_parent()
	mundo.add_child(lulu_inst)
	mundo.add_child(wilson_inst)
	
	if lulu_inst.has_node("Camera2D"):
		lulu_inst.get_node("Camera2D").make_current()
	
	queue_free()

func reset_to_start():
	global_position = starting_position
	velocity = Vector2.ZERO
