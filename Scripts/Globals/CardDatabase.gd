extends Node

const fireDeckDetails = { # Health, Energy, Attack 1, Attack 2, Attack 3, Card Type, Image Path
	"FireGiant" : [5, 4, "FireBlast", "FireStorm2", "", "Monster", "res://Assets/Art/FireDeck/FireGiant.png"],
	"FlameGoblin" : [2, 1, "Swipe", "FireBlast", "", "Monster", "res://Assets/Art/FireDeck/FlameGoblin.png"],
	"FireSpawn" : [3, 2, "Swipe", "FireStorm", "", "Monster", "res://Assets/Art/FireDeck/FireSpawn.png"],
	"FlameChieftan" : [6, 5, "FireBlast2", "FireCharge", "", "Monster", "res://Assets/Art/FireDeck/FlameChieftan.png"],
	"Fireball" : [1, 2, "Fireball", "", "", "", "Spell", "res://Assets/Art/FireDeck/SpellFireball.png"],
	"Exchange" : [1, 2, "Exchange", "", "", "", "Spell", "res://Assets/Art/FireDeck/SpellExchange.png"],
	"StokeFlames" : [1, 4, "StokeFlames", "", "", "", "Spell", "res://Assets/Art/FireDeck/StokeFlames.png"],
	"ReIgnite" : [1, 3, "ReIgnite", "", "", "", "Spell", "res://Assets/Art/FireDeck/ReIgnite.png"],
	"IcarusPhoenix" : [8, 7, "FireClaw", "FireBlast3", "InfernalExplosion", "Monster", "res://Assets/Art/FireDeck/IcarusPhoenix.png"],
	"IcarusSphere" : [7, 1000, "", "", "PhoenixBurst", "Monster", "res://Assets/Art/FireDeck/IcarusEgg.png"]
}

const waterDeckDetails = { # Health, Energy, Attack 1, Attack 2, Attack 3, Card Type, Image Path
	"Dethaw" : [1, 3, "Dethaw", "", "", "", "Spell", "res://Assets/Art/WaterDeck/Dethaw.png"],
	"WaterSpout" : [1, 2, "WaterSpout", "", "", "", "Spell", "res://Assets/Art/WaterDeck/WaterSpout.png"],
	"Exchange" : [1, 2, "Exchange", "", "", "", "Spell", "res://Assets/Art/WaterDeck/Exchange.png"],
	"IceAttack" : [1, 2, "IceAttack", "", "", "", "Spell", "res://Assets/Art/WaterDeck/IceAttack.png"],
	"IceDrake" : [6, 5, "FrostClaw", "GlacialShard", "", "Monster", "res://Assets/Art/WaterDeck/IceDrake.png"],
	"FrozenWyrmling" : [3, 3, "FrostSnap", "IcyBreath", "", "Monster", "res://Assets/Art/WaterDeck/Frozenwyrmling.png"],
	"WavecallerSiren" : [3, 4, "WaterSurge", "SirensCall", "", "Monster", "res://Assets/Art/WaterDeck/WavecallerSiren.png"],
	"WaterSpirit" : [2, 2, "WaterSplash", "", "", "Monster", "res://Assets/Art/WaterDeck/WaterSpirit.png"],
	"TidalCrab" : [1, 2, "ClawSnap", "BubbleBlast", "", "Monster", "res://Assets/Art/WaterDeck/TidalCrab.png"],
	"IcemawFrozenDragon" : [8, 6, "IceClaw", "IceShard", "FrozenHurricane", "res://Assets/Art/WaterDeck/IcemawFrozenDragon.png"]
}
