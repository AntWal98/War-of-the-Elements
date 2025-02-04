extends Node2D

signal left_mouse_clicked
signal left_mouse_released

const COLLISION_MASK_CARD: int = 1
const COLLISION_MASK_CARD_SLOT: int = 2
const COLLISION_MASK_DECK: int = 4

var card_manager_reference: Node2D
var deck_reference: Node2D

func _ready() -> void:
	card_manager_reference = $"../CardManager"
	deck_reference = $"../PlayerDeck"

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("left_mouse_clicked")
			raycast_at_cursor()
		else:
			emit_signal("left_mouse_released")

func raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		var result_collision_mask = result[0].collider.collision_mask
		if result_collision_mask == COLLISION_MASK_CARD:
			#Card Clicked
			var card_found = result[0].collider.get_parent()
			if card_found:
				card_manager_reference.card_clicked(card_found)
		elif result_collision_mask == COLLISION_MASK_DECK:
			#Deck Clicked
			deck_reference.draw_card()
