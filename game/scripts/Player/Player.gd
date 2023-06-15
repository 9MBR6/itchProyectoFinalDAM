extends KinematicBody2D


export (int) var speed = 300
onready var _animatedSprite = $AnimatedSprite

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		_animatedSprite.play("Derecha")
		_animatedSprite.flip_h = false
		velocity.x += 1
	elif Input.is_action_pressed("ui_left"):
		_animatedSprite.play("Izquierda")
		_animatedSprite.flip_h = true
		velocity.x -= 1
	elif Input.is_action_pressed("ui_down"):
		_animatedSprite.play("Abajo")
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		_animatedSprite.play("Arriba")
		
		velocity.y -= 1
	else:
		_animatedSprite.play("Parado")
	velocity = velocity.normalized() * speed



func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
