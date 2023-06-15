extends Node2D


export (PackedScene) var Enemy
export (PackedScene) var EnemyFast
export (PackedScene) var EnemyZigZag
export (PackedScene) var BoosEnemy
export (PackedScene) var Boos1Enemy
#este score es para las misiones y se le suma al score final
var score: int = 0
var tiempo: float = 0
var enemisDead: int = 0
var enemiKills: int = 0
#variables de las misiones
var arrayEspejo=[]
var _scoreBatir: int
var _tiempoBatir: int
var _enemisBatir: int
var bScore: bool = false
var bsTimer: bool = false
var bEnemisDead: bool = false
var numAleatorio: int = 0

func inicioEnemi():
	match GLOBAL.naveSeleccionada:
		1:
			$EnemyTimer.wait_time = 1
			$EnemyFastTimer.wait_time = 3
			$EnemyZigZagTimer.wait_time = 10
			$BoosTimer.wait_time = 30
			$Boos1Timer.wait_time = 50
		2:
			$EnemyTimer.wait_time = 1
			$EnemyFastTimer.wait_time = 3
			$EnemyZigZagTimer.wait_time = 4
			$BoosTimer.wait_time = 20
			$Boos1Timer.wait_time = 30
		3:
			$EnemyTimer.wait_time = 1
			$EnemyFastTimer.wait_time = 1
			$EnemyZigZagTimer.wait_time = 2
			$BoosTimer.wait_time = 15
			$Boos1Timer.wait_time = 20

func _ready():
	randomize()
	numAleatorio = randi() % 3
	
	match numAleatorio:
		0:
			$sound1.playing = true
		1:
			$sound2.playing = true
		2:
			$sound3.playing = true
	inicioEnemi()
	seleccionNave()
	anadirArray()
	$HUD_GameOver.hide()
	$EnemyTimer.start()
	$EnemyFastTimer.start()
	$EnemyZigZagTimer.start()
	$BoosTimer.start()
	$Boos1Timer.start()
	misionesActivas()
	#maxScore  EnemyDeadCount
	GLOBAL.connect("enemyDead",self,"EnemyDeadCount")
	GLOBAL.connect("maxScore",self,"scoreEnemigo")
	randomize()

func seleccionNave():
	match GLOBAL.naveSeleccionada:
		1:
			$PlayerShip2.queue_free()
			$PlayerShip3.queue_free()
		2:
			$PlayerShip1.queue_free()
			$PlayerShip3.queue_free()
		3:
			$PlayerShip1.queue_free()
			$PlayerShip2.queue_free()

func _physics_process(delta):
	#señal emitida por enemigos
	#1 vez por fotogramas y esta capada a 60
	get_node("background").scroll_base_offset += Vector2(0,1) * 8 * delta
	get_node("nube1").scroll_base_offset += Vector2(0,1) * 12 * delta
	get_node("nube2").scroll_base_offset += Vector2(0,1) * 34 * delta
	
	print(GLOBAL.score)

func scoreEnemigo(val):
	enemiKills = enemiKills +1
	score+=val
	$HUD_Espacio/Control/VBoxContainer/HBoxContainer3/Score_numero.text = str(score)
	$HUD_Espacio/Control/VBoxContainer/HBEnemyKills/LabelEnemyKills_numero.text = str(enemiKills)
	#realizar comprobacion de mision
	if bScore == true:
		misionScore()

func EnemyDeadCount(val):
	if bEnemisDead == true:
		enemisDead += val
		print(enemisDead)
		misionEnemy()

##REVISAR ESTO
func _on_PlayerShip1_gameOver():
	gameOverNaves()

##REVISAR ESTO
func _on_PlayerShip2_gameOver():
	gameOverNaves()

##REVISAR ESTO
func _on_PlayerShip3_gameOver():
	gameOverNaves()

##REVISAR ESTO
func gameOverNaves():
	$HUD_GameOver.visible = true
	$TimerMisiones.stop()
	eliminarMisionesArray()
	if score > GLOBAL.score:
		GLOBAL.score = score

func _on_EnemyTimer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = get_node("EnemyPath/EnemySpawn").position
	match GLOBAL.naveSeleccionada:
		1:
			$EnemyTimer.wait_time = GLOBAL.random(1,2)
		2:
			$EnemyTimer.wait_time = 1.0
		3:
			$EnemyTimer.wait_time = 1.0
	$EnemyTimer.start()


func _on_EnemyFastTimer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var enemyFast = EnemyFast.instance()
	add_child(enemyFast)
	enemyFast.position = get_node("EnemyPath/EnemySpawn").position
	match GLOBAL.naveSeleccionada:
		1:
			$EnemyFastTimer.wait_time = GLOBAL.random(1,4)
		2:
			$EnemyFastTimer.wait_time = GLOBAL.random(1,3)
			print("enemigo rapido nave 2")
		3:
			$EnemyFastTimer.wait_time = GLOBAL.random(1,2)
	$EnemyFastTimer.start()

func _on_EnemyZigZagTimer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var enemyZigZag = EnemyZigZag.instance()
	add_child(enemyZigZag)
	enemyZigZag.position = get_node("EnemyPath/EnemySpawn").position
	match GLOBAL.naveSeleccionada:
		1:
			$EnemyZigZagTimer.wait_time = GLOBAL.random(8,12)
		2:
			$EnemyZigZagTimer.wait_time = GLOBAL.random(4,8)
			print("enemigo zig nave 2")
		3:
			$EnemyZigZagTimer.wait_time = GLOBAL.random(2,4)
	$EnemyZigZagTimer.start()

func _on_BoosTimer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var boosEnemy = BoosEnemy.instance()
	add_child(boosEnemy)
	boosEnemy.position = get_node("EnemyPath/EnemySpawn").position
	match GLOBAL.naveSeleccionada:
		1:
			$BoosTimer.wait_time = 30.0
		2:
			$BoosTimer.wait_time = 20.0
			print("mini boss nave 2")
		3:
			$BoosTimer.wait_time = 15.0
	$BoosTimer.start()

func _on_Boos1Timer_timeout():
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	var boos1Enemy = Boos1Enemy.instance()
	add_child(boos1Enemy)
	boos1Enemy.position = get_node("EnemyPath/EnemySpawn").position
	match GLOBAL.naveSeleccionada:
		1:
			$Boos1Timer.wait_time = 50.0
		2:
			$Boos1Timer.wait_time = 30.0
		3:
			$Boos1Timer.wait_time = 20.0
	$Boos1Timer.start()

func _on_TimerMisiones_timeout():
	tiempo+=1
	score+=1
	#GLOBAL.score+=1
	if bScore == true:
		misionScore()
	if bsTimer == true:
		misionTimer()
	#$HUD_Espacio/Tiempo/Tiempo_numero.text = str(tiempo)
	$HUD_Espacio/Control/VBoxContainer/HBoxContainer6/Tiempo_numero.text = str(tiempo)
	$HUD_Espacio/Control/VBoxContainer/HBoxContainer3/Score_numero.text = str(score)
	#$HUD_Espacio/LabelScore/Score_numero.text = str(score)

func anadirArray():
	arrayEspejo.append_array(GLOBAL.misionesAcetadas)

func misionesActivas():
	if GLOBAL.misionesAcetadas.size() != 0:
		for i in GLOBAL.misionesAcetadas.size():
			match GLOBAL.misionesAcetadas[i].tipo:
				"MissionScore":
					_scoreBatir = i
					bScore = true
				"MissionTimer":
					bsTimer = true
					_tiempoBatir = i
				"MissionEnemy":
					bEnemisDead = true
					_enemisBatir = i

func misionScore():
	if score >= GLOBAL.misionesAcetadas[_scoreBatir].scoreBatir:
		bScore = false
		eliminarMisionesHUD(_scoreBatir)
		GLOBAL.misionesAcetadas[_scoreBatir].completada()
		#eliminar

func misionTimer():
	if tiempo >= GLOBAL.misionesAcetadas[_tiempoBatir].timeBatir:
		bsTimer = false
		eliminarMisionesHUD(_tiempoBatir)
		GLOBAL.misionesAcetadas[_tiempoBatir].completada()
		#eliminar

func misionEnemy():
	print(GLOBAL.misionesAcetadas[_enemisBatir].enemisBatir)
	if enemisDead >= GLOBAL.misionesAcetadas[_enemisBatir].enemisBatir:
		bEnemisDead = false
		eliminarMisionesHUD(_enemisBatir)
		GLOBAL.misionesAcetadas[_enemisBatir].completada()

func eliminarMisionesHUD(posicionMision):
	match GLOBAL.misionesAcetadas[posicionMision].tipo:
		"MissionScore":
			comprobarPosicionHUD("S")
		"MissionTimer":
			comprobarPosicionHUD("T")
		"MissionEnemy":
			comprobarPosicionHUD("E")

func comprobarPosicionHUD(letraEST):
	if $HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission1.text.substr(0,1)== str(letraEST):
		$HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission1.text = "Completada"
	elif $HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission2.text.substr(0,1)== str(letraEST):
		$HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission2.text = "Completada"
	elif $HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission3.text.substr(0,1)== str(letraEST):
		$HUD_MissionsSpace/Missions/VBoxContainer/Label_Mission3.text = "Completada"


func eliminarMisionesArray():
	GLOBAL.misionesAcetadas.clear()
	print(arrayEspejo)
	for i in arrayEspejo.size():
		if arrayEspejo[i].eliminada == false:
			GLOBAL.misionesAcetadas.append(arrayEspejo[i])




