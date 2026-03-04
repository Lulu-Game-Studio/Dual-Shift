extends Area2D

func _ready():
	$Panel.hide() 

func _on_body_entered(body):
	if body.name == "Lulu" or body.name == "Wilson" or body.name == "Fusion":
		$Panel.show()

func _on_body_exited(body):
	if body.name == "Lulu" or body.name == "Wilson" or body.name == "Fusion":
		$Panel.hide()
