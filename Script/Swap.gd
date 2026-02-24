extends Node2D

var lulu_is_active = true

func _ready():
	update_characters()

func _input(event):
	if event.is_action_pressed("Swap Character"):
		lulu_is_active = !lulu_is_active
		update_characters()

func update_characters():
	var lulu = get_tree().current_scene.find_child("Lulu",true,false)
	var wilson = get_tree().current_scene.find_child("Wilson", true, false)
	
	if lulu:
		lulu.is_active = lulu_is_active
		lulu.get_node("Camera2D").enabled = lulu_is_active
		lulu.modulate.a = 1.0 if lulu_is_active else 0.5
	if wilson:
		wilson.is_active = !lulu_is_active
		wilson.get_node("Camera2D").enabled = !lulu_is_active
		wilson.modulate.a = 0.5 if lulu_is_active else 1.0
