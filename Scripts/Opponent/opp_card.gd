extends Node2D

var card_type: String
var starting_position: Vector2
var health: int
var card_slot_card_is_in

@onready var health_label: Label = %HealthLabel
