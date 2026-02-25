extends Area2D

func _ready():
	$Panel.hide() 

func _on_body_entered(body):
	if body.is_in_group("Lulu") or body.is_in_group("Wilson") or body.is_in_group("fusion"):
		$Panel.show()

func _on_body_exited(body):
	if body.is_in_group("Lulu") or body.is_in_group("Wilson") or body.is_in_group("fusion"):
		$Panel.hide()
