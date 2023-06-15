extends KinematicBody2D

export (PackedScene) var Explosion
export (PackedScene) var Shoot

export (int) var speed = 150 
var cantidadEscudos: int =0
var velocity = Vector2()
onready var can_shoot : bool = true
signal gameOver

func _ready():
	speed+=GLOBAL.nave1.motor
	cantidadEscudos = GLOBAL.nave1.escudo
	print("Velocidad del jugador: ", speed)
	print("Velocidad disparo del jugador: ", GLOBAL.nave1.velocidadDisparo)
	print("Escudos ORIGINALES: ", GLOBAL.nave1.escudo)
	print("Escudos de la partida: ", cantidadEscudos)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.animation = "horizontal"
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.animation = "vertical"
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.animation = "vertical"
	
	if Input.is_action_just_released("ui_right"):
		$AnimatedSprite.animation = "vertical"
	
	if Input.is_action_just_released("ui_left"):
		$AnimatedSprite.animation = "vertical"
	
	velocity = velocity.normalized() * speed
	
	
	position.x = clamp(position.x,283,741)#original 256, 768
	position.y = clamp(position.y,40,560) #original 0, 600


func _physics_process(delta):
	get_input()
	_shoot()
	velocity = move_and_slide(velocity)


func _shoot():
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot_ctrl()
		can_shoot = false
		$RetardoDisparo.wait_time=GLOBAL.nave1.velocidadDisparo
		$RetardoDisparo.start()


func shoot_ctrl():
	var shoot = Shoot.instance()
	shoot.global_position = $ShootSpawn.global_position
	get_tree().call_group("level", "add_child", shoot)


func _on_RetardoDisparo_timeout():
	can_shoot = true


func _on_Area2D_area_entered(area):
	if area.is_in_group("shootPlayer"):
		if(cantidadEscudos>0):
			cantidadEscudos-=1
			explosion_ctrl()
			area.queue_free()
		else:
			queue_free()
			explosion_ctrl()
			gameOver()
	if area.is_in_group("enemy"):
		area.queue_free()
		area.explosion_ctrl()
		queue_free()
		explosion_ctrl()
		gameOver()

func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionPoint.global_position
	get_tree().call_group("level", "add_child", explosion)

func gameOver():
	emit_signal("gameOver")

