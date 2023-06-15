extends Missions

class_name MissionTimer

var timeBatir: float

func _init(_nombre, _descripcion, _experiencia, _creditos, _timeBatir,_descripcionCorta, _descripcionSpace):
	tipo = "MissionTimer"
	nombre = _nombre
	descripcion = _descripcion
	experiencia = _experiencia
	creditos = _creditos
	timeBatir = _timeBatir
	descripcionCorta = _descripcionCorta
	descripcionSpace = _descripcionSpace
