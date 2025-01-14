extends Node

var HPtowin: int = 30

var playerStartHealth: int = 0
var playerHealth: int
var enemyStartHealth: int = 0
var enemyHealth: int

var fireRed = Color(255, 36, 0)
var winterBlue = Color(240,255,255)

var turnTime: int = 300

var maxPlayerCreatures: int = 3
var maxEnemyCreatures: int = 3
var playerCreatures: int
var enemyCreatures: int
var playerEnergy: int
var enemyEnergy: int

var maxDeckSize: int = 40
var startHand: int = 5

var cardType = ["Creature", "Quick Spell", "Normal Spell", "Energy"]
var cardEffects = ["Frozen", "Burn", "Sleep"]
var creatureTier = ["Tier 1", "Tier 2", "Tier 3"]

const DEFAULT_CARD_MOVE_SPEED = 0.5
