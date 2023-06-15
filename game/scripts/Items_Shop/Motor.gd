extends ItemBase

class_name Motor

var velocidad: int

func _init(_nombre, _descripcion, _precio, _velocidad):
	tipo = "Motor"
	nombre = _nombre
	descripcion = _descripcion
	precio = _precio
	velocidad = _velocidad
