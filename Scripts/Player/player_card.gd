extends Node2D

signal hovered
signal hovered_off
signal card_destroyed

var starting_position: Vector2
var card_in_slot
var card_type: String
@onready var health_label: Label = %HealthLabel

@onready var card_image: Sprite2D = $CardImage

var health: int
var ability1
var ability2
var ability3
var energy: int

var effect: String
var can_attack: bool
var effect_turns_remaining: int
var burn_applied: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

#func change_card_image(image: Texture2D):
	#card_image.set_texture(image)

func takeDamage(damage: int):
	if card_type == "Spell":
		return
	
	health -= damage
	if health <= 0:
		emit_signal("card_destroyed", self)

func apply_effect(atkeffect, turns):
	if effect:
		return
	
	effect = atkeffect
	effect_turns_remaining = turns
	
	if effect == "Frozen" or effect == "Hypnotized":
		can_attack = false
	
	if effect == "Burn":
		pass
	
	elif effect == "Sphere":
		can_attack = false

func update_effect_status():
	if effect_turns_remaining == 0:
		return
	
	effect_turns_remaining -= 1
	
	if effect_turns_remaining <= 0:
		reset_effect_status()

func reset_effect_status():
	effect = ""
	if !can_attack:
		can_attack = true

func burnDamage():
	if effect != "burn":
		return
	
	var burnDamage = randi_range(1, 3)
	takeDamage(burnDamage)
	burn_applied = true
	update_effect_status()

func cycleEffects():
	if !self.effect:
		return
	
	burnDamage()
