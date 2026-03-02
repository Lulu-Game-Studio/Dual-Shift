extends Area2D

func _on_body_entered(body):
	if body.has_method("reset_to_start"):
		body.reset_to_start()
