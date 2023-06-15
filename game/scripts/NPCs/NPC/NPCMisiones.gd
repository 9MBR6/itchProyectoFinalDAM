extends Area2D

var cerrarMisiones:bool = false

func _ready():
	$Sprite_tecla.visible = false

func _on_NPC_body_entered(body):
	if body.is_in_group("player"):
		print("el jugador está en la zona")
		$Sprite_tecla.visible = true


func _on_NPC_body_exited(body):
	if body.is_in_group("player"):
		print("el jugador está fuera en la zona")
		$Sprite_tecla.visible = false
		if(cerrarMisiones):
			GLOBAL.emit_signal("HUDMissionsInvisible")
			cerrarMisiones = false

func _input(event):
	if event.is_action_pressed("ui_select") and $Sprite_tecla.visible == true:
			print("se pulsó espacio")
			get_tree().paused = true
			var dialogoNPC = Dialogic.start("NPC_Misiones")
			dialogoNPC.pause_mode = Node.PAUSE_MODE_PROCESS
			dialogoNPC.connect("timeline_end", self, "unpause")
			add_child(dialogoNPC)

func unpause(timeline_name):
	get_tree().paused = false
	GLOBAL.emit_signal("HUDMissionsVisible")
	cerrarMisiones = true
