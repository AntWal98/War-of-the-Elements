extends Node2D

var opp_deck: Array = [ # Going with the WATER deck for this build.
		"Dethaw",
		"WaterSpout",
		"Exchange",
		"Dethaw",
		"WaterSpout",
		"Exchange",
		"IceAttack",
		"IceDrake",
		"FrozenWyrmling",
		"IceDrake",
		"FrozenWyrmling",
		"WavecallerSiren",
		"WavecallerSiren",
		"WaterSpirit",
		"WaterSpirit",
		"WaterSpirit",
		"TidalCrab",
		"TidalCrab",
		"TidalCrab",
		"IcemawFrozenDragon"]
		
var card_manager_reference: Node2D
var card_database

@onready var opp_deck_count: Label = %OppDeckCount
@onready var opp_hand: Node2D = %OppHand


const CARD_SCENE_PATH = "res://Scenes/Opponent/opp_card.tscn"
const CARD_DRAW_SPEED = 0.2
const STARTING_HAND_SIZE = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	opp_deck.shuffle()
	card_manager_reference = %CardManager
	opp_deck_count.text = str(opp_deck.size())
	card_database = preload("res://Scripts/Globals/CardDatabase.gd")
	
	for i in range(STARTING_HAND_SIZE):
		draw_card()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_card():
	#if drawn_card_this_turn:
		#return

	#drawn_card_this_turn = true
	
	var card_drawn = opp_deck[0]
	opp_deck.erase(card_drawn)
	
	if opp_deck.size() == 0:
		#$Area2D/CollisionShape2D.disabled = true
		$OppDeckImage.visible = false
		opp_deck_count.visible = false
	
	opp_deck_count.text = str(opp_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	
	new_card.health = card_database.waterDeckDetails[card_drawn][0]
	new_card.get_node("HealthLabel").text = str(new_card.health)
	new_card.card_type = str(card_database.waterDeckDetails[card_drawn][5])
	new_card.energy = card_database.waterDeckDetails[card_drawn][1]
	
	# Set abilities of the card
	new_card.ability1 = str(card_database.waterDeckDetails[card_drawn][2])
	new_card.ability2 = str(card_database.waterDeckDetails[card_drawn][3])
	new_card.ability3 = str(card_database.waterDeckDetails[card_drawn][4])
	%CardManager.add_child(new_card)
	new_card.name = "OppCard"
	%OppHand.add_card_to_hand(new_card, CARD_DRAW_SPEED)
