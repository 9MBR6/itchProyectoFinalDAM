extends CanvasLayer
#nave 1
#velocidad de disparo implementada
onready var laser1 = Laser.new("LF1", "LASER LF1", 1000, 1.2)
onready var laser2 = Laser.new("LF2", "LASER LF2", 1500, 1.0)
onready var laser3 = Laser.new("LF3", "LASER LF3", 2000, 0.9)

#estamos trabajando en ello
onready var escudo1 = Escudo.new("EX1", "ESCUDO EX1", 1000, 1)
onready var escudo2 = Escudo.new("EX2", "ESCUDO EX2", 1500, 1)
onready var escudo3 = Escudo.new("EX3", "ESCUDO EX3", 2000, 1)

#velocidad implementada
onready var motor1 = Motor.new("MT1", "Motor MT1", 1000, 5)
onready var motor2 = Motor.new("MT2", "Motor MT2", 1500, 5)
onready var motor3 = Motor.new("MT3", "Motor MT3", 2000, 10)

#nave 2
onready var laser12 = Laser.new("LF1", "LASER LF12", 2500, 1.0)
onready var laser22 = Laser.new("LF2", "LASER LF22", 5000, 0.9)
onready var laser32 = Laser.new("LF3", "LASER LF32", 7500, 0.8)

onready var escudo12 = Escudo.new("EX1", "ESCUDO EX12", 2500, 1)
onready var escudo22 = Escudo.new("EX2", "ESCUDO EX22", 5000, 1)
onready var escudo32 = Escudo.new("EX3", "ESCUDO EX32", 7500, 2)

onready var motor12 = Motor.new("MT1", "Motor MT12", 2500, 10)
onready var motor22 = Motor.new("MT2", "Motor MT22", 5000, 10)
onready var motor32 = Motor.new("MT3", "Motor MT32", 7500, 20)

#nave 3
onready var laser13 = Laser.new("LF1", "LASER LF13", 10000, 1.3)
onready var laser23 = Laser.new("LF2", "LASER LF23", 15000, 1.2)
onready var laser33 = Laser.new("LF3", "LASER LF33", 20000, 1.0)

onready var escudo13 = Escudo.new("EX1", "ESCUDO EX13", 10000, 2)
onready var escudo23 = Escudo.new("EX2", "ESCUDO EX23", 15000, 2)
onready var escudo33 = Escudo.new("EX3", "ESCUDO EX33", 20000, 3)

onready var motor13 = Motor.new("MT1", "Motor MT13", 10000, 5)
onready var motor23 = Motor.new("MT2", "Motor MT23", 15000, 5)
onready var motor33 = Motor.new("MT3", "Motor MT33", 20000, 10)


func _ready():
	$Panel_Control.hide()
	
	comprobarLvPlayer()
	#nave1
	comprobacionComprasLaser()
	comprobacionComprasEscudo()
	comprobacionComprasMotor()
	#nave2
	comprobacionComprasLaserN2()
	comprobacionComprasEscudoN2()
	comprobacionComprasMotorN2()
	#nave3
	comprobacionComprasLaserN3()
	comprobacionComprasEscudoN3()
	comprobacionComprasMotorN3()
	
	GLOBAL.connect("HUDShopVisible",self,"mostrarTienda")
	GLOBAL.connect("HUDShopInvisible",self,"ocultarTienda")

func comprobarLvPlayer():
	$Panel_Control/Btn_Nave2.hide()
	$Panel_Control/Btn_Nave3.hide()
	
	if GLOBAL.lv >=10:
		$Panel_Control/Btn_Nave2.visible = true
	
	if GLOBAL.lv >=20:
		$Panel_Control/Btn_Nave3.visible = true

func mostrarTienda():
	$Panel_Control.visible = !$Panel_Control.visible

func ocultarTienda():
	$Panel_Control.hide()

func _on_Btn_Laser_Compra_pressed():
	sonidoClick()
	for i in GLOBAL.nave1.mejorasLaser.size():
		if(GLOBAL.nave1.mejorasLaser[i]==false):
			if(GLOBAL.creditos >= buscadoLaser(i).precio):
				GLOBAL.creditos -= buscadoLaser(i).precio
				GLOBAL.nave1.mejorasLaser[i]=true
				GLOBAL.nave1.velocidadDisparo = buscadoLaser(i).velocidadDisparo
				break
	comprobacionComprasLaser()
	print("Velocidad disparo del jugador: ", GLOBAL.nave1.velocidadDisparo)
	if(GLOBAL.nave1.mejorasLaser[2]==true):
		laserFull()


func buscadoLaser(i) -> Laser:
	var laser
	match i:
		0:
			laser = laser1
		1:
			laser = laser2
		2:
			laser = laser3
	return laser

func comprobacionComprasLaser():
	for i in GLOBAL.nave1.mejorasLaser.size():
		if(GLOBAL.nave1.mejorasLaser[i] == false):
			match i:
				0:
					compraLaser(laser1)
				1:
					compraLaser(laser2)
				2:
					compraLaser(laser3)
			break
	if(GLOBAL.nave1.mejorasLaser[2]==true):
		laserFull()


func compraLaser(Laser):
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Nombre.text = "Nombre: "+Laser.nombre
	#$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Descripcion.text = "Descripción: \n\n "+Laser.descripcion
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de disparo de\nla nave."
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Precio.text = "Precio: "+str(Laser.precio)


func laserFull():
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Btn_Laser_Compra.disabled = true
	$Panel_Control/Fondo_Tienda/Fondo_Laser/Laser_Precio.hide()


##################################ESCUDO#######################################

func _on_Btn_Escudo_Compra_pressed():
	sonidoClick()
	for i in GLOBAL.nave1.mejorasEscudo.size():
		if(GLOBAL.nave1.mejorasEscudo[i]==false):
			if(GLOBAL.creditos >= buscadoEscudo(i).precio):
				GLOBAL.creditos-= buscadoEscudo(i).precio
				GLOBAL.nave1.mejorasEscudo[i]=true
				GLOBAL.nave1.escudo += buscadoEscudo(i).defensa
				break
	comprobacionComprasEscudo()
	print("Escudo del jugador: "+str(GLOBAL.nave1.escudo))
	if(GLOBAL.nave1.mejorasEscudo[2]==true):
		escudoFull()


func buscadoEscudo(i) -> Escudo:
	var escudo
	match i:
		0:
			escudo = escudo1
		1:
			escudo = escudo2
		2:
			escudo = escudo3
	return escudo

func comprobacionComprasEscudo():
	for i in GLOBAL.nave1.mejorasEscudo.size():
		if(GLOBAL.nave1.mejorasEscudo[i] == false):
			match i:
				0:
					compraEscudo(escudo1)
				1:
					compraEscudo(escudo2)
				2:
					compraEscudo(escudo3)
			break
	if(GLOBAL.nave1.mejorasEscudo[2]==true):
		escudoFull()

func compraEscudo(Escudo):
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Escudo_Nombre.text = "Nombre: "+Escudo.nombre
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Escudo_Descripcion.text = "Descripción: \n\nAumenta la resis-\ntencia de la nave."
	
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Escudo_Precio.text = "Precio: "+str(Escudo.precio)

func escudoFull():
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Escudo_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Btn_Escudo_Compra.disabled = true
	$Panel_Control/Fondo_Tienda/Fondo_Escudo/Escudo_Precio.hide()

####################################MOTOR##########################################3

func _on_Btn_Motor_Compra_pressed():
	sonidoClick()
	for i in GLOBAL.nave1.mejorasMotor.size():
		if(GLOBAL.nave1.mejorasMotor[i]==false):
			if(GLOBAL.creditos >= buscadoMotor(i).precio):
				GLOBAL.creditos -= buscadoMotor(i).precio
				GLOBAL.nave1.mejorasMotor[i]=true
				GLOBAL.nave1.motor += buscadoMotor(i).velocidad
				break
	comprobacionComprasMotor()
	print("Velociad del jugador: "+str(GLOBAL.nave1.motor))
	if(GLOBAL.nave1.mejorasMotor[2]==true):
		motorFull()

func buscadoMotor(i) -> Motor:
	var motor
	match i:
		0:
			motor = motor1
		1:
			motor = motor2
		2:
			motor = motor3
	return motor

func comprobacionComprasMotor():
	for i in GLOBAL.nave1.mejorasMotor.size():
		if(GLOBAL.nave1.mejorasMotor[i] == false):
			match i:
				0:
					compraMotor(motor1)
				1:
					compraMotor(motor2)
				2:
					compraMotor(motor3)
			break
	if(GLOBAL.nave1.mejorasMotor[2]==true):
		motorFull()

func compraMotor(Motor):
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Motor_Nombre.text = "Nombre: "+Motor.nombre
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Motor_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de la nave."
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Motor_Precio.text = "Precio: "+str(Motor.precio)


func motorFull():
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Motor_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Btn_Motor_Compra.disabled = true
	$Panel_Control/Fondo_Tienda/Fondo_Motor/Motor_Precio.hide()

#################################################EMPESA AKI A LOCURA###############################################
##NAVE2
func _on_Btn_Laser_Compra2_pressed():
	sonidoClick()
	for i in GLOBAL.nave2.mejorasLaser.size():
		if(GLOBAL.nave2.mejorasLaser[i]==false):
			if(GLOBAL.creditos >= buscadoLaserN2(i).precio):
				GLOBAL.creditos -= buscadoLaserN2(i).precio
				GLOBAL.nave2.mejorasLaser[i]=true
				GLOBAL.nave2.velocidadDisparo = buscadoLaserN2(i).velocidadDisparo
				break
	comprobacionComprasLaserN2()
	print("Velocidad disparo del jugador: ", GLOBAL.nave2.velocidadDisparo)
	if(GLOBAL.nave2.mejorasLaser[2]==true):
		laserFullN2()


func buscadoLaserN2(i) -> Laser:
	var laser
	match i:
		0:
			laser = laser12
		1:
			laser = laser22
		2:
			laser = laser32
	return laser

func comprobacionComprasLaserN2():
	for i in GLOBAL.nave2.mejorasLaser.size():
		if(GLOBAL.nave2.mejorasLaser[i] == false):
			match i:
				0:
					compraLaserN2(laser12)
				1:
					compraLaserN2(laser22)
				2:
					compraLaserN2(laser32)
			break
	if(GLOBAL.nave2.mejorasLaser[2]==true):
		laserFullN2()


func compraLaserN2(Laser):
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Laser_Nombre.text = "Nombre: "+Laser.nombre
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Laser_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de disparo de\nla nave."
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Laser_Precio.text = "Precio: "+str(Laser.precio)


func laserFullN2():
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Laser_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Btn_Laser_Compra2.disabled = true
	$Panel_Control/Fondo_Tienda2/Fondo_Laser/Laser_Precio.hide()


##################################ESCUDO#######################################

func _on_Btn_Escudo_Compra2_pressed():
	sonidoClick()
	for i in GLOBAL.nave2.mejorasEscudo.size():
		if(GLOBAL.nave2.mejorasEscudo[i]==false):
			if(GLOBAL.creditos >= buscadoEscudoN2(i).precio):
				GLOBAL.creditos-= buscadoEscudoN2(i).precio
				GLOBAL.nave2.mejorasEscudo[i]=true
				GLOBAL.nave2.escudo += buscadoEscudoN2(i).defensa
				break
	comprobacionComprasEscudoN2()
	print("Escudo del jugador: "+str(GLOBAL.nave2.escudo))
	if(GLOBAL.nave2.mejorasEscudo[2]==true):
		escudoFullN2()


func buscadoEscudoN2(i) -> Escudo:
	var escudo
	match i:
		0:
			escudo = escudo12
		1:
			escudo = escudo22
		2:
			escudo = escudo32
	return escudo

func comprobacionComprasEscudoN2():
	sonidoClick()
	for i in GLOBAL.nave2.mejorasEscudo.size():
		if(GLOBAL.nave2.mejorasEscudo[i] == false):
			match i:
				0:
					compraEscudoN2(escudo12)
				1:
					compraEscudoN2(escudo22)
				2:
					compraEscudoN2(escudo32)
			break
	if(GLOBAL.nave2.mejorasEscudo[2]==true):
		escudoFullN2()

func compraEscudoN2(Escudo):
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Escudo_Nombre.text = "Nombre: "+Escudo.nombre
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Escudo_Descripcion.text = "Descripción: \n\nAumenta la resis-\ntencia de la nave."
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Escudo_Precio.text = "Precio: "+str(Escudo.precio)

func escudoFullN2():
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Escudo_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Btn_Escudo_Compra2.disabled = true
	$Panel_Control/Fondo_Tienda2/Fondo_Escudo/Escudo_Precio.hide()

####################################MOTOR##########################################3

func _on_Btn_Motor_Compra2_pressed():
	sonidoClick()
	for i in GLOBAL.nave2.mejorasMotor.size():
		if(GLOBAL.nave2.mejorasMotor[i]==false):
			if(GLOBAL.creditos >= buscadoMotorN2(i).precio):
				GLOBAL.creditos -= buscadoMotorN2(i).precio
				GLOBAL.nave2.mejorasMotor[i]=true
				GLOBAL.nave2.motor += buscadoMotorN2(i).velocidad
				break
	comprobacionComprasMotorN2()
	print("Velociad del jugador: "+str(GLOBAL.nave2.motor))
	if(GLOBAL.nave2.mejorasMotor[2]==true):
		motorFullN2()

func buscadoMotorN2(i) -> Motor:
	var motor
	match i:
		0:
			motor = motor12
		1:
			motor = motor22
		2:
			motor = motor32
	return motor

func comprobacionComprasMotorN2():
	for i in GLOBAL.nave2.mejorasMotor.size():
		if(GLOBAL.nave2.mejorasMotor[i] == false):
			match i:
				0:
					compraMotorN2(motor12)
				1:
					compraMotorN2(motor22)
				2:
					compraMotorN2(motor32)
			break
	if(GLOBAL.nave2.mejorasMotor[2]==true):
		motorFullN2()

func compraMotorN2(Motor):
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Motor_Nombre.text = "Nombre: "+Motor.nombre
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Motor_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de la nave."
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Motor_Precio.text = "Precio: "+str(Motor.precio)


func motorFullN2():
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Motor_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Btn_Motor_Compra2.disabled = true
	$Panel_Control/Fondo_Tienda2/Fondo_Motor/Motor_Precio.hide()

##NAVE3

func _on_Btn_Laser_Compra3_pressed():
	sonidoClick()
	for i in GLOBAL.nave3.mejorasLaser.size():
		if(GLOBAL.nave3.mejorasLaser[i]==false):
			if(GLOBAL.creditos >= buscadoLaserN3(i).precio):
				GLOBAL.creditos -= buscadoLaserN3(i).precio
				GLOBAL.nave3.mejorasLaser[i]=true
				GLOBAL.nave3.velocidadDisparo = buscadoLaserN3(i).velocidadDisparo
				break
	comprobacionComprasLaserN3()
	print("Velocidad disparo del jugador: ", GLOBAL.nave3.velocidadDisparo)
	if(GLOBAL.nave3.mejorasLaser[2]==true):
		laserFullN3()


func buscadoLaserN3(i) -> Laser:
	var laser
	match i:
		0:
			laser = laser13
		1:
			laser = laser23
		2:
			laser = laser33
	return laser

func comprobacionComprasLaserN3():
	for i in GLOBAL.nave3.mejorasLaser.size():
		if(GLOBAL.nave3.mejorasLaser[i] == false):
			match i:
				0:
					compraLaserN3(laser13)
				1:
					compraLaserN3(laser23)
				2:
					compraLaserN3(laser33)
			break
	if(GLOBAL.nave3.mejorasLaser[2]==true):
		laserFullN3()


func compraLaserN3(Laser):
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Laser_Nombre.text = "Nombre: "+Laser.nombre
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Laser_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de disparo de\nla nave."
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Laser_Precio.text = "Precio: "+str(Laser.precio)


func laserFullN3():
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Laser_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Btn_Laser_Compra3.disabled = true
	$Panel_Control/Fondo_Tienda3/Fondo_Laser/Laser_Precio.hide()


##################################ESCUDO#######################################

func _on_Btn_Escudo_Compra3_pressed():
	sonidoClick()
	for i in GLOBAL.nave3.mejorasEscudo.size():
		if(GLOBAL.nave3.mejorasEscudo[i]==false):
			if(GLOBAL.creditos >= buscadoEscudoN3(i).precio):
				GLOBAL.creditos-= buscadoEscudoN3(i).precio
				GLOBAL.nave3.mejorasEscudo[i]=true
				GLOBAL.nave3.escudo += buscadoEscudoN3(i).defensa
				break
	comprobacionComprasEscudoN3()
	print("Escudo del jugador: "+str(GLOBAL.nave3.escudo))
	if(GLOBAL.nave3.mejorasEscudo[2]==true):
		escudoFullN3()


func buscadoEscudoN3(i) -> Escudo:
	var escudo
	match i:
		0:
			escudo = escudo13
		1:
			escudo = escudo23
		2:
			escudo = escudo33
	return escudo

func comprobacionComprasEscudoN3():
	for i in GLOBAL.nave3.mejorasEscudo.size():
		if(GLOBAL.nave3.mejorasEscudo[i] == false):
			match i:
				0:
					compraEscudoN3(escudo13)
				1:
					compraEscudoN3(escudo23)
				2:
					compraEscudoN3(escudo33)
			break
	if(GLOBAL.nave3.mejorasEscudo[2]==true):
		escudoFullN3()

func compraEscudoN3(Escudo):
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Escudo_Nombre.text = "Nombre: "+Escudo.nombre
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Escudo_Descripcion.text = "Descripción: \n\nAumenta la resis-\ntencia de la nave."
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Escudo_Precio.text = "Precio: "+str(Escudo.precio)

func escudoFullN3():
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Escudo_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Btn_Escudo_Compra3.disabled = true
	$Panel_Control/Fondo_Tienda3/Fondo_Escudo/Escudo_Precio.hide()

####################################MOTOR##########################################3

func _on_Btn_Motor_Compra3_pressed():
	sonidoClick()
	for i in GLOBAL.nave3.mejorasMotor.size():
		if(GLOBAL.nave3.mejorasMotor[i]==false):
			if(GLOBAL.creditos >= buscadoMotorN3(i).precio):
				GLOBAL.creditos -= buscadoMotorN3(i).precio
				GLOBAL.nave3.mejorasMotor[i]=true
				GLOBAL.nave3.motor += buscadoMotorN3(i).velocidad
				break
	comprobacionComprasMotorN3()
	print("Velociad del jugador: "+str(GLOBAL.nave3.motor))
	if(GLOBAL.nave3.mejorasMotor[2]==true):
		motorFullN3()

func buscadoMotorN3(i) -> Motor:
	var motor
	match i:
		0:
			motor = motor13
		1:
			motor = motor23
		2:
			motor = motor33
	return motor

func comprobacionComprasMotorN3():
	for i in GLOBAL.nave3.mejorasMotor.size():
		if(GLOBAL.nave3.mejorasMotor[i] == false):
			match i:
				0:
					compraMotorN3(motor13)
				1:
					compraMotorN3(motor23)
				2:
					compraMotorN3(motor33)
			break
	if(GLOBAL.nave3.mejorasMotor[2]==true):
		motorFullN3()

func compraMotorN3(Motor):
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Motor_Nombre.text = "Nombre: "+Motor.nombre
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Motor_Descripcion.text = "Descripción: \n\nAumenta la veloci-\ndad de la nave."
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Motor_Precio.text = "Precio: "+str(Motor.precio)


func motorFullN3():
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Motor_Descripcion.text = "FULL ÉLITE"
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Btn_Motor_Compra3.disabled = true
	$Panel_Control/Fondo_Tienda3/Fondo_Motor/Motor_Precio.hide()

#####################################################akacaba aki##############################################
#ACABAR DE HACER ESTO

func _on_Btn_Nave1_pressed():
	sonidoClick()
	$Panel_Control/Fondo_Tienda.visible = true
	$Panel_Control/Fondo_Tienda2.hide()
	$Panel_Control/Fondo_Tienda3.hide()


func _on_Btn_Nave2_pressed():
	sonidoClick()
	$Panel_Control/Fondo_Tienda2.visible = true
	$Panel_Control/Fondo_Tienda.hide()
	$Panel_Control/Fondo_Tienda3.hide()


func _on_Btn_Nave3_pressed():
	sonidoClick()
	$Panel_Control/Fondo_Tienda3.visible = true
	$Panel_Control/Fondo_Tienda.hide()
	$Panel_Control/Fondo_Tienda2.hide()


func _on_Button_pressed():
	$Panel_Control.hide()

func sonidoMouse():
	$sonidoMouse.playing = true

func sonidoClick():
	$sonidoclick.playing = true

func _on_Btn_Nave1_mouse_entered():
	sonidoMouse()


func _on_Btn_Nave2_mouse_entered():
	sonidoMouse()


func _on_Btn_Nave3_mouse_entered():
	sonidoMouse()


func _on_Btn_Laser_Compra_mouse_entered():
	sonidoMouse()


func _on_Btn_Escudo_Compra_mouse_entered():
	sonidoMouse()


func _on_Btn_Motor_Compra_mouse_entered():
	sonidoMouse()


func _on_Button_mouse_entered():
	sonidoMouse()


func _on_Btn_Motor_Compra3_mouse_entered():
	sonidoMouse()


func _on_Btn_Escudo_Compra3_mouse_entered():
	sonidoMouse()


func _on_Btn_Laser_Compra3_mouse_entered():
	sonidoMouse()


func _on_Btn_Motor_Compra2_mouse_entered():
	sonidoMouse()


func _on_Btn_Escudo_Compra2_mouse_entered():
	sonidoMouse()


func _on_Btn_Laser_Compra2_mouse_entered():
	sonidoMouse()
