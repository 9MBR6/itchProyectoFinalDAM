extends CanvasLayer

#Lanzamos desde un primer momento que no se vea el mensaje de que no existe partida guardada.
func _ready():
	$MensajeNoGuardado.visible = false
	$HUD_Leer.visible = false

#Al nodo ParallaxBack le añadimos movimiento vertical.
func _physics_process(delta):
	get_node("Stars").scroll_base_offset += Vector2(0,1) * 50 * delta

#Botón de cargar partida, si existe una partida previa la cargara y emite un sonido.
func _on_Btn_Start_pressed():
	llamarSonidoBTN()
	cargar_partida()

#Botón de nueva partida, emite un sonido y crea una partida nueva, si se guada dentro de la partida
#se eliminará la que existe actualmente.
func _on_Btn_NewGame_pressed():
	llamarSonidoBTN()
	get_tree().change_scene("res://scenes/Test/TestScene.tscn")

#Botón de salir del juego, el cual cuando se llama empite un sonido y se cierra el juego.
func _on_Btn_Exit_pressed():
	llamarSonidoBTN()
	$TimerExit.start()

#En esta funcion establecemos unas pequeñas funciones para que nos cargue la partida o en su 
#defecto que nos muestre un mensaje por pantalla que no existe una partida guardada anteriormente.
#Ruta en windows: 
#Ruta en Linux: /home/manu/snap/gd-godot-engine-snapcraft/15/.local/share/godot/app_userdata/Save/save_game.sav
func cargar_partida():
	var archivo = File.new()
	if(!archivo.file_exists("user://Save/save_game.sav")):
		#mandar este mensaje al log
		print("no existe partida guardada")
		$MensajeNoGuardado.visible = true
		$TimerMD.start()
		return
	
	archivo.open("user://Save/save_game.sav", archivo.READ)
	
	var datos = SAVEDATA.variables_guardar
	
	if(!archivo.eof_reached()):
		datos = parse_json(archivo.get_line())
	
	GLOBAL.lv = datos.lv
	GLOBAL.experiencia = datos.experiencia
	GLOBAL.creditos = datos.creditos
	GLOBAL.score = datos.score
	GLOBAL.expPorcentual = datos.expPorcentual
	GLOBAL.expNecesaria = datos.expNecesaria
	GLOBAL.naveSeleccionada = int(datos.naveSeleccionada)
	
	#nave 1
	GLOBAL.nave1.velocidadDisparo = float(datos.nave1_velocidadDisparo)
	GLOBAL.nave1.escudo = int(datos.nave1_escudo)
	GLOBAL.nave1.motor = int(datos.nave1_motor)
	GLOBAL.nave1.mejorasLaser = datos.nave1_mejorasLaser
	GLOBAL.nave1.mejorasEscudo = datos.nave1_mejorasEscudo
	GLOBAL.nave1.mejorasMotor = datos.nave1_mejorasMotor
	#nave 2
	GLOBAL.nave2.velocidadDisparo = float(datos.nave2_velocidadDisparo)
	GLOBAL.nave2.escudo = int(datos.nave2_escudo)
	GLOBAL.nave2.motor = int(datos.nave2_motor)
	GLOBAL.nave2.mejorasLaser = datos.nave2_mejorasLaser
	GLOBAL.nave2.mejorasEscudo = datos.nave2_mejorasEscudo
	GLOBAL.nave2.mejorasMotor = datos.nave2_mejorasMotor
	#nave 3
	GLOBAL.nave3.velocidadDisparo = float(datos.nave3_velocidadDisparo)
	GLOBAL.nave3.escudo = int(datos.nave3_escudo)
	GLOBAL.nave3.motor = int(datos.nave3_motor)
	GLOBAL.nave3.mejorasLaser = datos.nave3_mejorasLaser
	GLOBAL.nave3.mejorasEscudo = datos.nave3_mejorasEscudo
	GLOBAL.nave3.mejorasMotor = datos.nave3_mejorasMotor
	
	get_tree().change_scene("res://scenes/Test/TestScene.tscn")

#Emite un sonido. 
func llamarSonidoBTN():
	$PressButtom.playing = true

#Emite un sonido cuando hacemos clic en el btn leer.
func _on_Button_pressed():
	llamarSonidoBTN()
	$TimerLeer.start()
	$HUD_Leer.visible = true

#Emite un sonido.
func mouseBtn():
	$MouseButtom.playing = true

#Emite un sonido al pasar el mouse por encima del botón cargar partida.
func _on_Btn_Start_mouse_entered():
	mouseBtn()

#Emite un sonido al pasar el mouse por encima del botón nueva partida.
func _on_Btn_NewGame_mouse_entered():
	mouseBtn()

#Emite un sonido al pasar el mouse por encima del botón salir.
func _on_Btn_Exit_mouse_entered():
	mouseBtn()

#Emite un sonido al pasar el mouse por encima del botón leer.
func _on_Button_mouse_entered():
	mouseBtn()

#un pequeño contador de unos 3 segundos el cual vuelve a esconder el mensaje de que no existe
#partida guardada.
func _on_Timer_timeout():
	$MensajeNoGuardado.visible = false

#Timer para cerrar el programa, se hace esto para cuando se hace click en el btn de salir
#el sonido se escuche entero.
func _on_TimerExit_timeout():
	get_tree().quit()


func _on_TimerLeer_timeout():
	$HUD_Leer.visible = false
