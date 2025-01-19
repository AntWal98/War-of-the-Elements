extends Node

@onready var turn_button: Button = %TurnButton
@onready var battle_timer: Timer = %BattleTimer
@onready var player_life_label: Label = %PlayerLifeLabel
@onready var opp_life_label: Label = %OppLifeLabel
@onready var opp_deck: Node2D = $"../../Opponent/OppDeck"
@onready var ability_manager: Node = $AbilityManager



var opponent_cards_on_battlefield: Array = []
var player_cards_on_battlefield: Array = []

var opponent_battle_time: float = 1.0

var empty_monster_card_slots: Array = []
var empty_spell_card_slots: Array = []

const CARD_SMALL_SCALE: float = 0.8
const CARD_MOVE_SPEED: float = 0.2
const DEFAULT_WAIT_TIME: float = 1.0
const STARTING_HEALTH: int = 1
const BATTLE_POS_OFFSET: float = 25.0

var player_health: int
var opponent_health: int
var hasBattled: bool

func _ready() -> void:
	empty_monster_card_slots.append($"../../CardSlots/Opp_MonsterSlot")
	empty_monster_card_slots.append($"../../CardSlots/Opp_MonsterSlot2")
	empty_monster_card_slots.append($"../../CardSlots/Opp_MonsterSlot3")
	empty_spell_card_slots.append($"../../CardSlots/Opp_SpellSlot")
	empty_spell_card_slots.append($"../../CardSlots/Opp_SpellSlot2")
	empty_spell_card_slots.append($"../../CardSlots/Opp_SpellSlot3")
	
	player_health = STARTING_HEALTH
	player_life_label.text = str(player_health)
	opponent_health = STARTING_HEALTH
	opp_life_label.text = str(opponent_health)

func _process(delta: float) -> void:
	if !hasBattled:
		turn_button.visible = false
	elif hasBattled:
		turn_button.visible = true

func wait(wait_time: float):
	battle_timer.wait_time = wait_time
	
	# Waits for desiganted time
	battle_timer.start()
	await battle_timer.timeout

func _on_turn_button_pressed() -> void:
	opponent_turn()

func opponent_turn():
	turn_button.disabled = true
	turn_button.visible = false
	
	# Wait 1 second
	await wait(DEFAULT_WAIT_TIME)
	
	if $"../../Opponent/OppDeck".opp_deck.size() != 0:
		opp_deck.draw_card()
		await wait(DEFAULT_WAIT_TIME)
	
	var opp_hand = %OppHand.opponent_hand
	if opp_hand.size() == 0:
		end_opponent_turn()
		
	# Check if free spell slot first
	if empty_spell_card_slots.size() != 0:
		await try_play_spell(opp_hand)
	
	# Check for free monster slots, then try to play highest atk
	if empty_monster_card_slots.size() != 0:
		await try_play_monster(opp_hand)
	
	# Try to attack

func try_play_spell(hand):	
	var random_spell_slots = empty_spell_card_slots[randi_range(-1, empty_spell_card_slots.size())]
	empty_spell_card_slots.erase(random_spell_slots)
	
	# Play a random spell
	var opponent_spells: Array = hand.filter(func(card):
		return card.card_type == "Spell"
	)
	
	var spell_selected
	if opponent_spells.size() == 0:
		return
	else:
		spell_selected = opponent_spells.pick_random()
	
	# Animate card to pos
	var tween = get_tree().create_tween()
	tween.tween_property(spell_selected, "position", random_spell_slots.position, CARD_MOVE_SPEED)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(spell_selected, "scale", Vector2(CARD_SMALL_SCALE, CARD_SMALL_SCALE), CARD_MOVE_SPEED)
	
	# remove from opponent hand
	%OppHand.remove_card_from_hand(spell_selected)
	spell_selected.card_slot_card_is_in = random_spell_slots
	opponent_cards_on_battlefield.append(spell_selected)
	
	# Wait
	await wait(DEFAULT_WAIT_TIME)

func try_play_monster(hand):
	var random_empty_monster_slot = empty_monster_card_slots[randi_range(-1, empty_monster_card_slots.size())]
	empty_monster_card_slots.erase(random_empty_monster_slot)
	
	# Play card with highest attack
	var current_card_with_high_health = hand[0]
	for card in hand:
		if card.health > current_card_with_high_health.health:
			current_card_with_high_health = card

	# Animate card to pos
	var tween = get_tree().create_tween()
	tween.tween_property(current_card_with_high_health, "position", random_empty_monster_slot.position, CARD_MOVE_SPEED)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(current_card_with_high_health, "scale", Vector2(CARD_SMALL_SCALE, CARD_SMALL_SCALE), CARD_MOVE_SPEED)
	
	%OppHand.remove_card_from_hand(current_card_with_high_health)
	current_card_with_high_health.card_slot_card_is_in = random_empty_monster_slot
	opponent_cards_on_battlefield.append(current_card_with_high_health)

func end_opponent_turn():
	turn_button.disabled = false
	turn_button.visible = true
	
	# Reset Player Variables
	$"../../PlayerDeck".reset_draw()
	%CardManager.reset_played_monster()

# ABILITIES
