extends Node2D

var numAleatorio: int = 0

func _ready():
	randomize()
	numAleatorio = randi() % 2
	
	match numAleatorio:
		0:
			$Musica1.playing = true
		1:
			$Musica2.playing = true

