extends Node2D

var numAleatorio: int = 0

func _ready():
	$AnimatedSprite.play()
	$Timer.start()
	
	randomize()
	numAleatorio = randi() % 6
	
	match numAleatorio:
		0:
			$Explosion1.playing = true
		1:
			$Explosion2.playing = true
		2:
			$Explosion3.playing = true
		3:
			$Explosion4.playing = true
		4:
			$Explosion8.playing = true
		5:
			$Explosion7.playing = true


func _on_Timer_timeout():
	queue_free()






