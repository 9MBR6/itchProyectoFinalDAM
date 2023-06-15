extends Missions

class_name MissionScore

var scoreBatir: int

func _init(_nombre, _descripcion, _experiencia, _creditos, _scoreBatir,_descripcionCorta, _descripcionSpace):
	tipo = "MissionScore"
	nombre = _nombre
	descripcion = _descripcion
	experiencia = _experiencia
	creditos = _creditos
	scoreBatir = _scoreBatir
	descripcionCorta = _descripcionCorta
	descripcionSpace = _descripcionSpace
