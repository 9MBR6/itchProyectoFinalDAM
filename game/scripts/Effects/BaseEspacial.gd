extends Node2D


func _physics_process(delta):
	get_node("ParallaxBackground").scroll_base_offset += Vector2(-1,0) * 200 * delta
	get_node("ParallaxBackground2").scroll_base_offset += Vector2(-1,0) * 80 * delta
