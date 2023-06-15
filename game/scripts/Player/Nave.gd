extends Node


class_name Nave

var velocidadDisparo: float
var escudo:int 
var motor: int
var mejorasLaser 
var mejorasEscudo 
var mejorasMotor 

func _init(_velocidadDisparo, _escudo, _motor):
	velocidadDisparo = _velocidadDisparo
	escudo = _escudo
	motor = _motor
	mejorasLaser = [false,false,false]#max3
	mejorasEscudo = [false,false,false]#max3
	mejorasMotor = [false,false,false]#max3
