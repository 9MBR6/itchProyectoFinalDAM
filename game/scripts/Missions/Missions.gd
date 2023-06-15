extends Node

class_name Missions

var tipo: String
var nombre: String
var descripcion: String
var experiencia: int
var creditos: int
var eliminada = false
var descripcionCorta: String
var descripcionSpace: String

func completada():
	GLOBAL.experiencia += experiencia
	GLOBAL.creditos += creditos
	eliminada = true


func eliminarMision(posicionArray):
	GLOBAL.misionesAcetadas.remove(posicionArray)
	print("Posi eliminada")
	print(GLOBAL.misionesAcetadas)

