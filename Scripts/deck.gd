extends Node2D

var player_deck = ["Knight", "Knight", "Knight"]
var card_manager_reference: Node2D
@onready var deck_count: RichTextLabel = %DeckCount

const CARD_SCENE_PATH = "res://Scenes/card.tscn"
const CARD_DRAW_SPEED = 0.2
@onready var player_hand: Node2D = $"../PlayerHand"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_manager_reference = $"../CardManager"
	deck_count.text = str(player_deck.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$DeckImage.visible = false
		deck_count.visible = false
	
	deck_count.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	$"../CardManager".add_child(new_card)
	new_card.name = "Card"
	$"../PlayerHand".add_card_to_hand(new_card, CARD_DRAW_SPEED)
		
