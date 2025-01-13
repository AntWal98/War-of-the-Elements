extends Control

@export var water_game: PackedScene
@export var fire_game: PackedScene

@onready var fire_button: Button = %FireButton
@onready var water_button: Button = %WaterButton
@onready var return_button: Button = %ReturnButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_button.grab_focus()


func _on_fire_button_pressed() -> void:
	get_tree().change_scene_to_packed(fire_game)


func _on_water_button_pressed() -> void:
	get_tree().change_scene_to_packed(water_game)

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Interface/main_menu.tscn")
