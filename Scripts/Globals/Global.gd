extends Node

# Constants
const DEFAULT_CARD_MOVE_SPEED: float = 0.5
const DEFAULT_WAIT_TIME: float = 1.0

const fireRed = Color(255, 36, 0)
const winterBlue = Color(240,255,255)

const MAX_DECK_SIZE: int = 21
const STARTING_HAND: int = 5

var player_deck_chosen: String
var firstTurn: bool = false

#Defined game phases
var game_phases = { # Phase Value: Phase Name
	0: "Draw Phase",
	1: "Main Phase",
	2: "Battle Phase",
	3: "End Phase"
}

# Current Game Phase
var current_phase: int = 0

func set_phase(phase: int):
	if game_phases.has(phase): #Ensure the phase exists
		current_phase = phase
		print("Phase changed to:", game_phases[current_phase])
	else:
		print("Invalid phase:", phase)

# Get name of current phase
func get_current_phase_name():
	return game_phases.get(current_phase, "Unknown Phase")
