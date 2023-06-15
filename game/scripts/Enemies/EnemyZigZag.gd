extends Area2D

export (PackedScene) var Explosion
export (PackedScene) var Shoot

var speed
var direction = Vector2(-1, 1).normalized()

func _ready():
	$AnimatedSprite.play()
	speed = GLOBAL.random(75, 150)

func _physics_process(delta):
	if position.x > 720:
		direction = Vector2(-6, 1).normalized()
	elif position.x < 300:
		direction = Vector2(6, 1).normalized()
	var velocity = direction * speed * delta
	position += velocity

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
		#GLOBAL.score += 60
		GLOBAL.creditos+=80
		GLOBAL.experiencia+=6
		GLOBAL.emit_signal("maxScore",60)
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

