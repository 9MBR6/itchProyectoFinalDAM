extends Missions

class_name MissionEnemy

var enemisBatir: int

func _init(_nombre, _descripcion, _experiencia, _creditos, _enemisBatir,_descripcionCorta,_descripcionSpace):
	tipo = "MissionEnemy"
	nombre = _nombre
	descripcion = _descripcion
	experiencia = _experiencia
	creditos = _creditos
	enemisBatir = _enemisBatir
	descripcionCorta = _descripcionCorta
	descripcionSpace = _descripcionSpace

