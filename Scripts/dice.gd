extends Node2D

var diceRolling:bool = false
var diceVisible:bool

@onready var dice_text: RichTextLabel = %DiceText
@onready var dice_image: Sprite2D = $DiceImage


#signal rolled_one
#signal rolled_two
#signal rolled_three
#signal rolled_four
#signal rolled_five
#signal rolled_six
#signal rolled_seven
#signal rolled_eight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diceVisible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visibleDice()
	
	if Input.is_action_just_pressed("ui_left"):
		rollDice(6)

func rollDice(dice) -> void:
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
