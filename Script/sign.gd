extends Area2D

func _ready():
	$Panel.hide() 

func _on_body_entered(body):
	if body is CharacterBody2D:
		$Panel.show()

func _on_body_exited(body):
	if body is CharacterBody2D:
		$Panel.hide()
