extends CanvasLayer

func _ready():
	$Control.hide()

func guardarPartida():
	#ELIMINAR METODO AL ACABAR
	if Input.is_action_just_released("Guardar_partida"):
		$Control.visible = !$Control.visible
	"""
	if Input.is_action_pressed("creditos"):
		GLOBAL.creditos+=1000
		$"Fondo/Etiqueta_Créditos/Creditos_Jugador".text = String(GLOBAL.creditos)
	
	if Input.is_action_just_released("exp"):
		GLOBAL.experiencia+=1000
		$"Fondo/ProgressBar/numero_exp".text = String(GLOBAL.experiencia)
		$Fondo/ProgressBar.value = GLOBAL.experiencia
	"""


func _actualizar():
	$Fondo/Etiqueta_LV/Nivel_Jugador.text = str(GLOBAL.lv)
	$Fondo/ProgressBar.max_value = GLOBAL.expNecesaria
	$Fondo/ProgressBar.value = GLOBAL.experiencia
	$"Fondo/ProgressBar/numero_exp".text = String(GLOBAL.experiencia)
	$"Fondo/Etiqueta_Créditos/Creditos_Jugador".text = String(GLOBAL.creditos)

func _physics_process(delta):
	guardarPartida()
	_actualizar()
	
	

func _on_Save_Buttom_pressed():
	#guarda la partida
	#var save_filename = "user://save_game.save" 
	$click.playing = true
	var ruta = Directory.new()
	if(!ruta.dir_exists("user://Save")):
		ruta.make_dir("user://Save")
		print("carpeta creada")
	
	var archivo = File.new()
	archivo.open("user://Save/save_game.sav", archivo.WRITE)
	
	var datos = SAVEDATA.variables_guardar
	
	datos.lv = GLOBAL.lv
	datos.experiencia = GLOBAL.experiencia
	datos.creditos = GLOBAL.creditos
	datos.score = GLOBAL.score
	datos.expNecesaria = GLOBAL.expNecesaria
	datos.creditos = GLOBAL.creditos
	datos.naveSeleccionada = GLOBAL.naveSeleccionada
	#nave 1
	datos.nave1_velocidadDisparo = GLOBAL.nave1.velocidadDisparo
	datos.nave1_escudo = GLOBAL.nave1.escudo
	datos.nave1_motor = GLOBAL.nave1.motor
	datos.nave1_mejorasLaser = GLOBAL.nave1.mejorasLaser
	datos.nave1_mejorasEscudo = GLOBAL.nave1.mejorasEscudo
	datos.nave1_mejorasMotor = GLOBAL.nave1.mejorasMotor
	#nave 2
	datos.nave2_velocidadDisparo = GLOBAL.nave2.velocidadDisparo
	datos.nave2_escudo = GLOBAL.nave2.escudo
	datos.nave2_motor = GLOBAL.nave2.motor
	datos.nave2_mejorasLaser = GLOBAL.nave2.mejorasLaser
	datos.nave2_mejorasEscudo = GLOBAL.nave2.mejorasEscudo
	datos.nave2_mejorasMotor = GLOBAL.nave2.mejorasMotor
	#nave 3
	datos.nave3_velocidadDisparo = GLOBAL.nave3.velocidadDisparo
	datos.nave3_escudo = GLOBAL.nave3.escudo
	datos.nave3_motor = GLOBAL.nave3.motor
	datos.nave3_mejorasLaser = GLOBAL.nave3.mejorasLaser
	datos.nave3_mejorasEscudo = GLOBAL.nave3.mejorasEscudo
	datos.nave3_mejorasMotor = GLOBAL.nave3.mejorasMotor
	
	archivo.store_line(to_json(datos))
	archivo.close()
	$Control.hide()


func _on_Save_Buttom_mouse_entered():
	$mouse.playing = true
