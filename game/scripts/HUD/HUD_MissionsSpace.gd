extends CanvasLayer

class_name HudMissionSpace

func _ready():
	if GLOBAL.misionesAcetadas.size()!=0:
		for i in GLOBAL.misionesAcetadas.size():
			llenarDatosEtiquetas(i)
# no la uso
func vaciarEtiquetas():
	$Missions/VBoxContainer/Label.text = ""
	$Missions/VBoxContainer/Label2.text = ""
	$Missions/VBoxContainer/Label3.text = ""
	$Missions/VBoxContainer/Label4.text = ""

func llenarDatosEtiquetas(i):
	if $Missions/VBoxContainer/Label_Mission1.text == "":
		$Missions/VBoxContainer/Label_Mission1.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionSpace
	elif $Missions/VBoxContainer/Label_Mission2.text == "":
		$Missions/VBoxContainer/Label_Mission2.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionSpace
	elif $Missions/VBoxContainer/Label_Mission3.text == "":
		$Missions/VBoxContainer/Label_Mission3.text = GLOBAL.misionesAcetadas[i].nombre+"\n"+GLOBAL.misionesAcetadas[i].descripcionSpace

