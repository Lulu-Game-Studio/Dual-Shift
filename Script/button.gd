extends Area2D

@export var image_not_pressed : Texture2D
@export var image_pressed : Texture2D

signal actived
signal disabled

var counter_objects = 0

func _on_body_entered(body):
	if body is RigidBody2D:
		counter_objects += 1
		if counter_objects == 1:
			$Sprite2D.texture = image_pressed
			emit_signal("actived")

func _on_body_exited(body):
	if body is RigidBody2D:
		counter_objects -= 1
		if counter_objects <= 0:
			$Sprite2D.texture = image_not_pressed
			emit_signal("disabled")
