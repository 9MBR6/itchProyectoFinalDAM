extends CanvasLayer


func _ready():
	$Panel_Control.hide()
	comprobarLvPlayer()
	GLOBAL.connect("HUDSelectorShip",self,"mostrarselector")
	GLOBAL.connect("HUDSelectorShipInvisible",self,"ocultarselector")


func comprobarLvPlayer():
	$Panel_Control/Btn_Nave2.hide()
	$Panel_Control/Sprite_Nave2.hide()
	$Panel_Control/Btn_Nave3.hide()
	$Panel_Control/Sprite_Nave3.hide()
	
	if GLOBAL.lv >=10:
		$Panel_Control/Btn_Nave2.visible = true
		$Panel_Control/Sprite_Nave2.visible = true
	
	if GLOBAL.lv >=20:
		$Panel_Control/Btn_Nave3.visible = true
		$Panel_Control/Sprite_Nave3.visible = true
"""
func _physics_process(delta):
	if Input.is_action_just_released("Hangar"):
		$Panel_Control.visible = !$Panel_Control.visible
"""

#enviar señal para activar o desactivar las naves en la escena test
func mostrarselector():
	$Panel_Control.visible = !$Panel_Control.visible

func ocultarselector():
	$Panel_Control.hide()


func selectorNave(numeroNave):
	print("Nave seleccionada nave ",numeroNave)
	GLOBAL.naveSeleccionada=numeroNave
	$Panel_Control.visible=false

func _on_Btn_Nave1_pressed():
	audioclickPlay()
	selectorNave(1)


func _on_Btn_Nave2_pressed():
	audioclickPlay()
	selectorNave(2)


func _on_Btn_Nave3_pressed():
	audioclickPlay()
	selectorNave(3)

func audioclickPlay():
	$audioClic.playing = true

func audioMouse():
	$audioMouse.playing = true

func _on_Btn_Nave1_mouse_entered():
	audioMouse()


func _on_Btn_Nave2_mouse_entered():
	audioMouse()


func _on_Btn_Nave3_mouse_entered():
	audioMouse()
