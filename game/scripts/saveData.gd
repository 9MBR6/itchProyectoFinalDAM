extends Node

"""
Archivo en el cual ponemos la estructura del cuerpo del archivo de guardado, tiene que ser
un .SAV
mejorasLaser = [false,false,false]#max3
mejorasEscudo = [false,false,false]#max3
	mejorasMotor = [false,false,false]#max3
"""
var variables_guardar = {
	"lv" : 0,
	"experiencia" :0,
	"creditos" : 0,
	"score" : 0,
	"expNecesaria" :10,
	"expPorcentual" :0.0,
	"naveSeleccionada" :1,
	"nave1_velocidadDisparo" :1.5,
	"nave1_escudo" : 0,
	"nave1_motor" :0,
	"nave1_mejorasLaser" :[false,false,false],
	"nave1_mejorasEscudo" :[false,false,false],
	"nave1_mejorasMotor" :[false,false,false],
	"nave2_velocidadDisparo" :0.8,
	"nave2_escudo" : 1,
	"nave2_motor" :50,
	"nave2_mejorasLaser" :[false,false,false],
	"nave2_mejorasEscudo" :[false,false,false],
	"nave2_mejorasMotor" :[false,false,false],
	"nave3_velocidadDisparo" :1.0,
	"nave3_escudo" : 3,
	"nave3_motor" :30,
	"nave3_mejorasLaser" :[false,false,false],
	"nave3_mejorasEscudo" :[false,false,false],
	"nave3_mejorasMotor" :[false,false,false]
}
