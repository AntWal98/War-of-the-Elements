extends Node2D

var screen_size
var card_being_dragged
var is_hovering_on_card: bool
var player_hand_reference: Node2D
var monster_card_played: bool = false
@onready var input_manager: Node2D = $"../InputManager"

const COLLISION_MASK_CARD: int = 1
const COLLISION_MASK_CARD_SLOT: int = 2
const DEFAULT_CARD_SCALE: float = 0.8
const BIG_CARD_SCALE: float = 0.85
const CARD_SMALL_SCALE: float = 0.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_hand_reference = $"../PlayerHand"
	input_manager.connect("left_mouse_button_released", on_left_click_released)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y))

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		return get_card_with_highest_z_index(result)
	return null

func raycast_check_for_card_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		return result[0].collider.get_parent()
	return null

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)
	
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)
	
func on_hovered_off_card(card):
	# Checks if card is in card slot AND not being dragged
	if !card.card_in_slot && !card_being_dragged:
		highlight_card(card, false)
		# Check if hovered off one card, straight onto another card.
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered, true)
		else:
			is_hovering_on_card = false

func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(BIG_CARD_SCALE, BIG_CARD_SCALE)
		card.z_index = 2
	else:
		card.scale = Vector2(DEFAULT_CARD_SCALE,DEFAULT_CARD_SCALE)
		card.z_index = 1

func get_card_with_highest_z_index(cards):
	# Assume first card has the highest z index to start
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	# Loop through cards looking for highest Z index
	for i in range(1, cards.size()):
		var current_card = cards[i].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
	return highest_z_card

func start_drag(card):
	card_being_dragged = card
	card.scale = Vector2(DEFAULT_CARD_SCALE,DEFAULT_CARD_SCALE)

func finish_drag():
	card_being_dragged.scale = Vector2(BIG_CARD_SCALE, BIG_CARD_SCALE)
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found and not card_slot_found.card_in_slot:
		# If card is a monster
		if card_being_dragged.card_type == "Monster":
			player_hand_reference.remove_card_from_hand(card_being_dragged)
			# Card dropped in card slot
			card_being_dragged.scale = Vector2(CARD_SMALL_SCALE,CARD_SMALL_SCALE)
			card_being_dragged.card_in_slot = card_slot_found
			card_being_dragged.z_index = -1
			
			# Card dropped in empty card slot
			card_being_dragged.position = card_slot_found.position
			card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
			card_slot_found.card_in_slot = true
	else:
		player_hand_reference.add_card_to_hand(card_being_dragged, GlobalV.DEFAULT_CARD_MOVE_SPEED)
	card_being_dragged = null

func on_left_click_released():
	if card_being_dragged:
		finish_drag()
