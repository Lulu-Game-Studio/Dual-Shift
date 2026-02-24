extends Node2D

@onready var lulu = $Lulu
@onready var wilson = $Wilson
@onready var main_camera = $Camera2D 

var lulu_is_active = true
var target_node = null

func _ready():
	target_node = lulu
	update_characters()

func _process(_delta):
	if target_node:
		main_camera.global_position = target_node.global_position

func _input(event):
	if event.is_action_pressed("Swap Character"):
		lulu_is_active = !lulu_is_active 
		target_node = lulu if lulu_is_active else wilson
		update_characters()

func update_characters():
	lulu.set_physics_process(lulu_is_active)
	lulu.modulate.a = 1.0 if lulu_is_active else 0.5
	
	wilson.set_physics_process(!lulu_is_active)
	wilson.modulate.a = 0.5 if lulu_is_active else 1.0
