extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var Shoot
var speed
var vida = 1
var direction = Vector2.RIGHT




func _ready():
	$AnimatedSprite.play()
	speed = 180

func _physics_process(delta):
	var velocity = direction * speed * delta
	position += velocity
	if position.x > 720:
		direction = Vector2.LEFT
		position.y += 5
	elif position.x < 300:
		direction = Vector2.RIGHT
		position.y += 5

func death_enemy():
	queue_free()
	explosion_ctrl()

func explosion_ctrl():
	var explosion = Explosion.instance()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", explosion)


func _on_Area2D_area_entered(area):
	if area.is_in_group("shoot"):
		vida -=1
		explosion_ctrl()
	
	if area.is_in_group("shoot") && vida==0:
		death_enemy()
		#GLOBAL.score += 100
		GLOBAL.creditos+=200
		GLOBAL.experiencia+=8
		GLOBAL.emit_signal("maxScore",100)
		GLOBAL.emit_signal("enemyDead",1)
	if area.is_in_group("BigShoot"):
		death_enemy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func shoot_ctrl():
	var shootEnemy1 = Shoot.instance()
	var shootEnemy2= Shoot.instance()
	var shootEnemy3= Shoot.instance()
	var shootEnemy4= Shoot.instance()
	shootEnemy1.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("level", "add_child", shootEnemy1)
	shootEnemy2.global_position = $ExplosionSpawn2.global_position
	get_tree().call_group("level", "add_child", shootEnemy2)
	shootEnemy3.global_position = $ExplosionSpawn3.global_position
	get_tree().call_group("level", "add_child", shootEnemy3)
	shootEnemy4.global_position = $ExplosionSpawn4.global_position
	get_tree().call_group("level", "add_child", shootEnemy4)


func _on_ShootTimer_timeout():
	shoot_ctrl()
