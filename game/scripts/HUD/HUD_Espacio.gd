extends CanvasLayer


func _ready():
	_actualizarHUD()
	cargarDatosNave()

func _actualizarHUD():
	$Control/VBoxContainer/HBoxContainer4/CD_numeros.text = str(GLOBAL.creditos)
	$Control/VBoxContainer/HBoxContainer5/LV_numero.text = str(GLOBAL.lv)
	$Control/VBoxContainer/HBBestScore/bsScore_numero.text = str(GLOBAL.score)

func cargarDatosNave():
	#150
	match GLOBAL.naveSeleccionada:
		1:
			$Control/VBoxContainer/HBLaser/LabelLaser_numero.text = str(GLOBAL.nave1.velocidadDisparo)
			$Control/VBoxContainer/HBEscudo/LabelEscudo_numero.text = str(GLOBAL.nave1.escudo)
			$Control/VBoxContainer/HBMotor/LabelMotor_numero.text = str((150+GLOBAL.nave1.motor))
		2:
			$Control/VBoxContainer/HBLaser/LabelLaser_numero.text = str(GLOBAL.nave2.velocidadDisparo)
			$Control/VBoxContainer/HBEscudo/LabelEscudo_numero.text = str(GLOBAL.nave2.escudo)
			$Control/VBoxContainer/HBMotor/LabelMotor_numero.text = str((150+GLOBAL.nave2.motor))
		3:
			$Control/VBoxContainer/HBLaser/LabelLaser_numero.text = str(GLOBAL.nave3.velocidadDisparo)
			$Control/VBoxContainer/HBEscudo/LabelEscudo_numero.text = str(GLOBAL.nave3.escudo)
			$Control/VBoxContainer/HBMotor/LabelMotor_numero.text = str((150+GLOBAL.nave3.motor))

func _physics_process(delta):
	_actualizarHUD()
