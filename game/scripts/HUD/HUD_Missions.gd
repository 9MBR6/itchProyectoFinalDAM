extends CanvasLayer
#func _init(_nombre, _descripcion, _experiencia, _creditos, _scoreBatir,"desc_corta"):
var mision0 = MissionEnemy.new("Enemy", "\n\nDerrota a 25 enemigos.\n\nRecompensa:\n\nExperiencia - 100 \n\nCréditos - 100", 100, 100, 25, "Derrota 25 naves", "\n\nMata 25 naves\n\nRecompensa:\n\nEXP- 100 \n\nCD - 100")
var mision1 = MissionScore.new("Score", "\n\nBate 500 de score. \n\nRecompensa:\n\nExperiencia - 100 \n\nCréditos - 100", 100, 100, 500,"Consigue 500 pts", "\n\nBate 500 score \n\nRecompensa:\n\nEXP - 100 \n\nCD - 100")
var mision2 = MissionTimer.new("Timer", "\n\nAguanta 100 segundos. \n\nRecompensa:\n\nExperiencia - 300 \n\nCréditos - 300", 300, 300, 100,"Aguanta 100s", "\n\nAguanta 100s \n\nRecompensa:\n\nEXP - 300 \n\nCD - 300")
var mision3 = MissionEnemy.new("Enemy", "\n\nDerrota a 50 enemigos.\n\nRecompensa:\n\nExperiencia - 800 \n\nCréditos - 1000", 800, 1000, 50,"Derrota 50 naves", "\n\nMata 50 naves\n\nRecompensa:\n\nEXP - 800 \n\nCD - 1000")
var mision4 = MissionScore.new("Score", "\n\nBate 5000 de score. \n\nRecompensa:\n\nExperiencia - 500 \n\nCréditos - 500", 500, 500, 5000,"Consigue 5000 pts", "\n\nBate 5000 score \n\nRecompensa:\n\nEXP - 500 \n\nCD - 500")
var mision5 = MissionTimer.new("Timer", "\n\nAguanta 200 segundos. \n\nRecompensa:\n\nExperiencia - 1000 \n\nCréditos - 2000", 1000, 2000, 200,"Aguanta 200s", "\n\nAguanta 200s \n\nRecompensa:\n\nEXP - 1000 \n\nCD - 2000")
var mision6 = MissionTimer.new("Enemy", "\n\nDerrota a 100 enemigos.\n\nRecompensa:\n\nExperiencia - 5000 \n\nCréditos - 5000", 5000, 5000, 100,"Derrota 100 naves","\n\nMata 100 naves\n\nRecompensa:\n\nEXP - 5000 \n\nCD - 5000")

onready var arrayMisiones=[mision0, mision1, mision2, mision3, mision4, mision5, mision6]
var misionSeleccionada: Missions


func _ready():
	
	for a in arrayMisiones.size():
		print(a)
	$Main_Panel.hide()
	if GLOBAL.misionesAcetadas.size()!=0:
		for i in GLOBAL.misionesAcetadas.size():
			llenarDatosEtiquetas(i)
	#no es necesario poner un else ya que cada vez que se carga la escena se carga con los 
	#valores de serie
	if GLOBAL.misionesAcetadas.size() == 3:
		$Main_Panel/Accept_Button.disabled = true
	else:
		$Main_Panel/Accept_Button.disabled = false
	
	GLOBAL.connect("HUDMissionsVisible",self,"mostrarMision")
	GLOBAL.connect("HUDMissionsInvisible",self,"ocultarMision")

func mostrarMision():
	$Main_Panel.visible = !$Main_Panel.visible

func ocultarMision():
	$Main_Panel.hide()

#este será el que se quede
func llenarDatosEtiquetas(i):
	if $Panel/Label.text == "":
		$Panel/Label.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionCorta
	elif $Panel/Label2.text == "":
		$Panel/Label2.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionCorta
	elif $Panel/Label3.text == "":
		$Panel/Label3.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionCorta


func _on_Mission_ItemList_item_selected(index):
	soundPressbtn()
	GLOBAL.indice = index
	misionSeleccionada = arrayMisiones[index]
	$Main_Panel/TextEdit.text = misionSeleccionada.nombre +"\n"+ misionSeleccionada.descripcion
	print(misionSeleccionada.tipo)
	for i in GLOBAL.misionesAcetadas:
		if misionSeleccionada.nombre == i.nombre:
			$Main_Panel/Accept_Button.disabled = true
			break
		else:
			$Main_Panel/Accept_Button.disabled = false


#con boton
"""
func _physics_process(delta):
	if Input.is_action_just_released("Missions"):
		$Main_Panel.visible = !$Main_Panel.visible
"""

func _on_Accept_Button_pressed():
	soundPressbtn()
	if GLOBAL.indice <0 or GLOBAL.indice >6:
		print("No se selecciono misión")
	else:
		if GLOBAL.misionesAcetadas.size() < 3:
			GLOBAL.misionesAcetadas.append(misionSeleccionada)
			filtrarMisiones()
			print(misionSeleccionada.nombre)
			$Main_Panel/Accept_Button.disabled = true
		if GLOBAL.misionesAcetadas.size() == 3:
			$Main_Panel/Accept_Button.disabled = true


func copiaDelBotonDeAceptar():
	if GLOBAL.misionesAcetadas.size() < 3:
		GLOBAL.misionesAcetadas.append(misionSeleccionada)
		filtrarMisiones()
		print(misionSeleccionada.nombre)
	if GLOBAL.misionesAcetadas.size() == 3:
		$Main_Panel/Accept_Button.disabled = true

func _on_Cancel_Button_pressed():
	soundPressbtn()
	$Main_Panel.hide()

#modificar para cada condición
func etiquetasVaciasGenericas():
	if $Panel/Label.text == "":
		$Panel/Label.text = misionSeleccionada.nombre+"\n"+misionSeleccionada.descripcionCorta
	elif $Panel/Label2.text == "":
		$Panel/Label2.text = misionSeleccionada.nombre+"\n"+misionSeleccionada.descripcionCorta
	elif $Panel/Label3.text == "":
		$Panel/Label3.text = misionSeleccionada.nombre+"\n"+misionSeleccionada.descripcionCorta

#cambiar luego para cada condicion que tenga su metodo
func filtrarMisiones():
	if misionSeleccionada.tipo == "MissionEnemy":
		etiquetasVaciasGenericas()
	if misionSeleccionada.tipo == "MissionScore":
		etiquetasVaciasGenericas()
	if misionSeleccionada.tipo == "MissionTimer":
		etiquetasVaciasGenericas()

func soundMouse():
	$mousebtn.playing = true

func soundPressbtn():
	$pressBtn.playing = true

func _on_Accept_Button_mouse_entered():
	if $Main_Panel/Accept_Button.disabled == false:
		soundMouse()


func _on_Cancel_Button_mouse_entered():
	soundMouse()
