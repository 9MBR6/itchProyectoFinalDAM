extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var ExplosionNoDeath
export (PackedScene) var Shoot
export (PackedScene) var LaserShoot

var speed
var vida = 15
var direction = Vector2.RIGHT
var disparaLaser = false




func _ready():
	$AnimatedSprite.play()
	speed = 100

func _physics_process(delta):
	var velocity = direction * speed * delta
	position += velocity
	if position.x > 480:
		direction = Vector2.LEFT
	elif position.x < 260:
		direction = Vector2.RIGHT

func death_enemy():
	queue_free()
	explosion_ctrl()

func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn5.global_position
	get_tree().call_group("level", "add_child", explosion)

func explosion_ctrl_NO_DEATH():
	var explosion = ExplosionNoDeath.instance()
	explosion.global_position = $ExplosionSpawn5.global_position
	get_tree().call_group("level", "add_child", explosion)


func _on_Area2D_area_entered(area):
	if area.is_in_group("shoot"):
		vida -=1
		explosion_ctrl_NO_DEATH()
	
	if area.is_in_group("shoot") && vida==0:
		death_enemy()
		#GLOBAL.score += 1000
		GLOBAL.creditos+=2000
		GLOBAL.experiencia+=500
		GLOBAL.emit_signal("maxScore",1000)
		GLOBAL.emit_signal("enemyDead",1)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func shoot_ctrl():
	var shootEnemy2= Shoot.instance()
	var shootEnemy4= Shoot.instance()
	var shootEnemy5= Shoot.instance()
	shootEnemy2.global_position = $ExplosionSpawn2.global_position
	get_tree().call_group("level", "add_child", shootEnemy2)
	shootEnemy4.global_position = $ExplosionSpawn4.global_position
	get_tree().call_group("level", "add_child", shootEnemy4)
	shootEnemy5.global_position = $ExplosionSpawn5.global_position
	get_tree().call_group("level", "add_child", shootEnemy5)

func laser_ctrl():
	var laserEnemy= LaserShoot.instance()
	laserEnemy.global_position = $LaserSpawn.global_position
	get_tree().call_group("level", "add_child", laserEnemy)

func _on_ShootTimer_timeout():
	shoot_ctrl()

#timer del laser
func _on_LaserTimer_timeout():
	if (disparaLaser):
		laser_ctrl()


func _on_TimerLaserTimer_timeout():
	disparaLaser = !disparaLaser
