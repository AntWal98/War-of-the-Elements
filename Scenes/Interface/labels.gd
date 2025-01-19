extends Node
@onready var phase_label: Label = %PhaseLabel
@onready var player_life_label: Label = %PlayerLifeLabel
@onready var opp_life_label: Label = %OppLifeLabel

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	update_phase_label()

func update_phase_label():
	match Global.current_phase:
		0:
			phase_label.text = "Draw Phase"
		1:
			phase_label.text = "Main Phase"
		2:
			phase_label.text = "Battle Phase"
		3:
			phase_label.text = "End Phase"
