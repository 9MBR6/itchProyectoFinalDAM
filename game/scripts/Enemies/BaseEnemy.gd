extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var Shoot
var speed



func _ready():
	$AnimatedSprite.play()
	speed = GLOBAL.random(30, 40)

func _physics_process(delta):
	position.y += speed*delta

func death_enemy():
	queue_free()
	explosion_ctrl()

func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", explosion)


func _on_Area2D_area_entered(area):
	if area.is_in_group("shoot"):
		death_enemy()
		#GLOBAL.score += 10
		GLOBAL.creditos+=50
		GLOBAL.experiencia+=2
		GLOBAL.emit_signal("maxScore",10)
		GLOBAL.emit_signal("enemyDead",1)
	if area.is_in_group("BigShoot"):
		death_enemy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func shoot_ctrl():
	var shootEnemy = Shoot.instance()
	shootEnemy.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", shootEnemy)


func _on_ShootTimer_timeout():
	shoot_ctrl()
