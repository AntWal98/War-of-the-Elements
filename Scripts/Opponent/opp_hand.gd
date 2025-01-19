extends Node2D

#const HAND_COUNT: int = 5
const CARD_WIDTH = 75
const HAND_Y_POSITION = 40
const DEFAULT_CARD_MOVE_SPEED = 0.1

var opponent_hand = []
var center_screen_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x = get_viewport_rect().size.x / 2
	#
	#var card_scene = preload(CARD_SCENE_PATH)
	#for i in range(HAND_COUNT):
		#var new_card = card_scene.instantiate()
		#$"../CardManager".add_child(new_card)
		#new_card.name = "Card"
		#add_card_to_hand(new_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_card_to_hand(card, speed):
	if card not in opponent_hand:
		opponent_hand.insert(0, card)
		update_hand_positions(speed)
	else:
		animate_card_to_position(card, card.starting_position, Global.DEFAULT_CARD_MOVE_SPEED)

func update_hand_positions(speed):
	for i in range(opponent_hand.size()):
		# Get new card position based on the index passed in
		var new_position = Vector2(calculate_card_position(i), HAND_Y_POSITION)
		var card = opponent_hand[i]
		card.starting_position = new_position
		animate_card_to_position(card, new_position, speed)

func calculate_card_position(index):
	var total_width = (opponent_hand.size() -1) * CARD_WIDTH
	var x_offset = center_screen_x - index * CARD_WIDTH + total_width / 2
	return x_offset

func animate_card_to_position(card, new_position, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", new_position, speed)

func remove_card_from_hand(card):
	if card in opponent_hand:
		opponent_hand.erase(card)
		update_hand_positions(Global.DEFAULT_CARD_MOVE_SPEED)
