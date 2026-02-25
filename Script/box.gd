extends RigidBody2D

func _ready():
	lock_rotation = true
	freeze = true
	contact_monitor = true
	
	can_sleep = false 

func _physics_process(_delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		if body.is_in_group("Lulu"):
			if freeze:
				freeze = false
		else:
			pass
