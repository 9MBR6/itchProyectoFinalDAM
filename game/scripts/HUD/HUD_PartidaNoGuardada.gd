extends CanvasLayer


func _ready():
	$Panel.hide()

func _on_Button_pressed():
	$PressBtn.playing=true
	$Panel.hide()
