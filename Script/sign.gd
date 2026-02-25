extends Area2D

@export_multiline var sign_text : String = "Write your message here"
@onready var message_label = $Label

func _ready():
	message_label.text = sign_text
	message_label.hide()

func _on_body_entered(body):
	if body.is_in_group("Lulu") or body.is_in_group("Wilson") or body.is_in_group("fusion"):
		message_label.show()

func _on_body_exited(body):
	if body.is_in_group("Lulu") or body.is_in_group("gato") or body.is_in_group("fusion"):
		message_label.hide()
