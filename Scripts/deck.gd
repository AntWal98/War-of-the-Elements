extends Node2D

var player_deck = ["Knight", "Archer", "Demon", "Archer", "Archer", "Archer"]
var card_manager_reference: Node2D
var card_database
var drawn_card_this_turn: bool = false
@onready var deck_count: RichTextLabel = %DeckCount

const CARD_SCENE_PATH = "res://Scenes/card.tscn"
const CARD_DRAW_SPEED = 0.2
const STARTING_HAND_SIZE = 5
@onready var player_hand: Node2D = $"../PlayerHand"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	card_manager_reference = $"../CardManager"
	deck_count.text = str(player_deck.size())
	card_database = preload("res://Scripts/CardDatabase.gd")
	
	for i in range(STARTING_HAND_SIZE):
		draw_card()
		drawn_card_this_turn = false
	
	drawn_card_this_turn = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_card():
	if drawn_card_this_turn:
		return

	drawn_card_this_turn = true
	
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$DeckImage.visible = false
		deck_count.visible = false
	
	deck_count.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	#var card_image_path = str()
	new_card.get_node("AttackLabel").text = str(card_database.CARDS[card_drawn][0])
	new_card.get_node("HealthLabel").text = str(card_database.CARDS[card_drawn][1])
	new_card.card_type = str(card_database.CARDS[card_drawn][2])
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
		
