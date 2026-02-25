extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var is_active = true
var wilson_nearby = false 
# He subido la fuerza a 500 para que se note el movimiento
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
	
	# LÓGICA DE EMPUJE MEJORADA
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is RigidBody2D:
			# PASO CLAVE: Si la caja está congelada, la descongelamos
			if body.freeze:
				body.freeze = false
			
			# Aplicamos el impulso. 
			# Usamos el normal de la colisión invertido para empujar hacia adelante
			body.apply_central_impulse(collision.get_normal() * -push_force)
	
	if Input.is_action_just_pressed("Interact"):
		if wilson_nearby:
			transform_now()

func transform_now():
	if get_parent().has_node("Fusion"): 
		return

	var fusion = load("res://Scenes/fusion.tscn").instantiate()
	fusion.global_position = global_position 
	
	get_parent().add_child(fusion)
	var wilson = get_parent().find_child("Wilson", true, false)
	if wilson:
		wilson.queue_free()
	
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name == "Wilson":
		wilson_nearby = true

func _on_area_2d_body_exited(body):
	if body.name == "Wilson":
		wilson_nearby = false
