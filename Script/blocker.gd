extends StaticBody2D

@onready var anim = $AnimationPlayer

func _on_button_actived() -> void:
	anim.play("open")


func _on_button_disabled() -> void:
	anim.play_backwards("open")


func _on_button_2_actived() -> void:
	anim.play("open")


func _on_button_2_disabled() -> void:
	anim.play_backwards("open")


func _on_button_3_actived() -> void:
	anim.play("open")


func _on_button_3_disabled() -> void:
	anim.play_backwards("open")



func _on_button_4_actived() -> void:
	anim.play("open")


func _on_button_4_disabled() -> void:
	anim.play_backwards("open")
