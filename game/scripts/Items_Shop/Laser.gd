extends ItemBase

class_name Laser

var velocidadDisparo: float

func _init(_nombre, _descripcion, _precio, _velocidadDisparo):
	tipo = "Laser"
	nombre = _nombre
	descripcion = _descripcion
	precio = _precio
	velocidadDisparo = _velocidadDisparo
