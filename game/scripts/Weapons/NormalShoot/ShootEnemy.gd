extends Area2D

#onready var player : KinematicBody2D = get_tree().get_nodes_in_group("player")[0]

export var speed = 500

func _ready():
	$AnimatedSprite.play("Shoot")

func _physics_process(delta):
	#movimiento en el eje Y
	position.y -= speed * delta


#elimina el disparo al chocar con un enemigo
func _on_Shoot_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()


#elimina el disparo al salir de la pantalla
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
