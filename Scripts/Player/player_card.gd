extends Node2D

signal hovered
signal hovered_off

var starting_position: Vector2
var card_slot
var card_type: String
@onready var health_label: Label = %HealthLabel

@onready var card_image: Sprite2D = $CardImage

var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func change_card_image(image: Texture2D):
	card_image.set_texture(image)
