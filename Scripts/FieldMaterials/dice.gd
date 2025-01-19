extends Node2D

var diceRolling: bool = false
var diceVisible: bool

@onready var dice_image: Sprite2D = $DiceImage
@onready var dice_text: Label = %DiceText
@onready var dice: Node2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diceVisible = false
	dice_image.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visibleDice()

func rolLDice(dice) -> void:
	if diceRolling == true:
		return
	
	else:
		diceRolling = true
		diceVisible = true
		
		var diceRoll = randi_range(1, dice)
		dice_text.text = str(diceRoll)
		print(str(diceRoll))
		
		diceRolling = false
		diceVisible = false

func visibleDice() -> void:
	if not diceVisible:
		dice_image.hide()
		dice_text.hide()
	
	elif diceVisible:
		dice_image.show()
		dice_text.show()
