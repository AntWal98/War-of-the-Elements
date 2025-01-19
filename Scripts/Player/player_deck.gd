extends Node2D

@onready var deck_image: Sprite2D = $DeckImage
var player_deck: Array = []
#var player_deck_chosen = "FireDeck"
var card_database = preload("res://Scripts/Globals/CardDatabase.gd")
@onready var deck_count: Label = %DeckCount

var fireDeckImage = preload("res://Assets/Art/DeckImage-Fire.png")
var waterDeckImage = preload("res://Assets/Art/DeckImage-Water.png")
var drawn_card_this_turn: bool = false
var first_turn: String

const CARD_SCENE_PATH = "res://Scenes/Player/player_card.tscn"
const CARD_DRAW_SPEED: float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await checkDeckType()
	print(str(player_deck))
	
	player_deck.shuffle()
	deck_count.text = str(player_deck.size())
	
	for i in range(Global.STARTING_HAND):
		draw_card()
		drawn_card_this_turn = false
	
	drawn_card_this_turn = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func checkDeckType():
	if Global.player_deck_chosen == "FireDeck":
		deck_image.texture = fireDeckImage
		loadFireDeck()
		return
	elif Global.player_deck_chosen == "WaterDeck":
		deck_image.set_texture(waterDeckImage)
		loadWaterDeck()
		return

func loadFireDeck():
	if Global.player_deck_chosen != "FireDeck" and player_deck.size() != 0:
		return
	
	var fire_deck: Array = [
		"FireGiant",
		"FireGiant",
		"FlameGoblin",
		"FlameGoblin",
		"FlameGoblin",
		"FlameChieftan",
		"FlameChieftan",
		"FireSpawn",
		"FireSpawn",
		"FireSpawn",
		"IcarusPhoenix",
		"IcarusSphere",
		"Exchange",
		"Exchange",
		"StokeFlames",
		"Fireball",
		"Fireball",
		"Fireball",
		"ReIgnite",
		"ReIgnite"
	]
	
	player_deck.assign(fire_deck)
	return

func loadWaterDeck():
	if Global.player_deck_chosen != "WaterDeck" and player_deck.size() != 0:
		return
		
	var water_deck: Array = [
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
		"IcemawFrozenDragon"
	]
	
	player_deck.assign(water_deck)
	return

func draw_card():
	# Checks to see if there was a card drawn this turn.
	if drawn_card_this_turn:
		return
	
	#Sets that a card was drawn.
	drawn_card_this_turn = true
	
	# Removes card from deck.
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	#Checks if the deck is 0. Future: Add an end game call right here.
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$DeckImage.visible = false
		%DeckCount.visible = false
	
	deck_count.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card = card_scene.instantiate()
	
	# Set card variables based on deck
	match Global.player_deck_chosen:
		"FireDeck":
			await new_card.change_card_image(card_database.fireDeckDetails[card_drawn][6])
			new_card.health = card_database.fireDeckDetails[card_drawn][0]
			new_card.health_label.text = str(new_card.health)
			new_card.card_type = str(card_database.fireDeckDetails[card_drawn][5])
			
			$"../CardManager".add_child(new_card)
			new_card.name = "Card"
			$"../PlayerHand".add_child_to_hand(new_card, CARD_DRAW_SPEED)
			return
		"WaterDeck":
			await new_card.change_card_image(card_database.waterDeckDetails[card_drawn][6])
			new_card.health = card_database.waterDeckDetails[card_drawn][0]
			new_card.health_label.text = str(new_card.health)
			new_card.card_type = str(card_database.waterDeckDetails[card_drawn][5])
			
			$"../CardManager".add_child(new_card)
			new_card.name = "Card"
			$"../PlayerHand".add_child_to_hand(new_card, CARD_DRAW_SPEED)
			return
	

func reset_draw():
	drawn_card_this_turn = false
