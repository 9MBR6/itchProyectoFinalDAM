extends CanvasLayer



func _on_Reintentar_pressed():
	$sonidoClick.playing = true
	get_tree().change_scene("res://scenes/SpaceScene/SpaceSceneDemo.tscn")


func _on_IrABase_pressed():
	$sonidoClick.playing = true
	get_tree().change_scene("res://scenes/Test/TestScene.tscn")


func _on_IrABase_mouse_entered():
	$sonidoMouse.playing = true


func _on_Reintentar_mouse_entered():
	$sonidoMouse.playing = true
