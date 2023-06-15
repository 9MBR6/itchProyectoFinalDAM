extends Area2D

export (PackedScene) var Explosion
var speed

func _ready():
	$AnimatedSprite.play()
	speed = GLOBAL.random(200, 300)

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
		#GLOBAL.score += 40
		GLOBAL.creditos+=80
		GLOBAL.experiencia+=4
		GLOBAL.emit_signal("maxScore",40)
		GLOBAL.emit_signal("enemyDead",1)
	if area.is_in_group("BigShoot"):
		death_enemy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
