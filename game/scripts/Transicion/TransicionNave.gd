extends Node2D



func _ready():
	get_tree().paused = false
	$Timer.start()

func _physics_process(delta):
	if $Panel/ProgressBar.value == 100:
		get_tree().change_scene("res://scenes/SpaceScene/SpaceSceneDemo.tscn")

func _on_Timer_timeout():
	$Panel/ProgressBar.value+=1
