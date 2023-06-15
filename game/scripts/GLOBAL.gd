extends Node

signal maxScore(val)
signal enemyDead(val)
signal HUDMissionsVisible()
signal HUDMissionsInvisible()
signal HUDShopVisible()
signal HUDShopInvisible()
signal HUDSelectorShip()
signal HUDSelectorShipInvisible()

onready var score : int = 0
onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()
#Variables globales del jugador
var lv = 0
var experiencia = 0
var creditos = 0
var expNecesaria = 10
var expPorcentual = 0.0
var misionesAcetadas = []#max 3
var indice = -1
###########################
# caracteristicas de las naves
# Nave 1
var nave1 = Nave.new(1.5, 0, 0)

# Nave 2
var nave2 = Nave.new(1.2, 1, 20)

# Nave 3
var nave3 = Nave.new(1.5, 2, 10)

var naveSeleccionada: int = 1

# Métodos globales
func random(min_number, max_number):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)
	return random

func maxCreditos():
	if creditos > 999999:
		creditos=999999

func maxlevel():
	if lv > 999999:
		lv = 999999

func subirLV():
	if(experiencia>=expNecesaria):
		lv+=1
		experiencia -= expNecesaria
		expPorcentual = (expNecesaria * 30)/100
		expNecesaria += expPorcentual

#REVISAR ESTE METODO YA QUE NO TENGO POR QUE PONERLO EN 1 VEZ POR SEGUNDO
func _physics_process(delta):
	subirLV()
	maxCreditos()
	maxlevel()

