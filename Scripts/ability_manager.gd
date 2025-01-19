extends Node

@onready var dice: Node2D = $"../../../Dice"
var ability_selected: String
var ability_used: bool = false

var target
var damage
var constant_attacks: Dictionary = {# Attack Name: Damage
	"Swipe": 1,
	"FireClaw": 3,
	"IceClaw": 3,
	"ClawSnap": 1,
	"FrostSnap": 2
}

const DEFAULT_WAIT_TIME: float = 1.0


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func triggerAbility(ability, attacking, attacker: String):
	if ability_used == true:
		return
	
	ability_selected = ability
	target = attacking
	ability_used = true
	

func resetAbility():
	ability_selected = ""
	target = null
	ability_used = false
	
# Monster Abilities
## FIRE DECK
func fireblast(target):
	damage = dice.rollDice(6)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return
	
func firestorm2(targets):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func swipe(target):
	damage = constant_attacks[ability_selected][1]
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func firecharge(target):
	damage = dice.rollDice(8)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func fireblast3(target):
	damage = dice.rollDice(6)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func fireblast2(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func infernalexplosion(target):
	pass

func firestorm(target):
	pass

## WATER DECK
func iceclaw(target):
	damage = constant_attacks[ability_selected][1]
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func iceshard(target):
	damage = dice.rollDice(6)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func frozenhurricane(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func clawsnap(target):
	damage = constant_attacks[ability_selected][1]
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func bubbleblast(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func watersplash(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func watersurge(target):
	damage = dice.rollDice(6)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func sirencall(target):
	pass

func frostclaw(target):
	damage = dice.rollDice(6)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func glacialshard(target):
	damage = dice.rollDice(8)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

# Spell Cards
func fireball(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func exchange(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func stokeflames(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func reignite(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func frostsnap(target):
	damage = constant_attacks[ability_selected][1]
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func icybreath(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

## WATER DECK
func dethaw(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func waterspout(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func iceattack(target):
	damage = dice.rollDice(4)
	target.takeDamage(damage)
	await wait(DEFAULT_WAIT_TIME)
	resetAbility()
	return

func wait(wait_time: float):
	await get_tree().create_timer(wait_time).timeout
