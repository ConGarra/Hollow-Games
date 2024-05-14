extends CharacterBody2D
class_name enemigo

@onready var sensor: Area2D = $"sensor"
@onready var movimiento: Node = $"movimiento"
@onready var player: CollisionObject2D
func _ready():
	movimiento.setup(self)


func _physics_process(delta):
	
	if player != null:
		var direction = player.global_position - global_position
		var distancia = global_position.distance_to(player.global_position)
		
		if distancia > 60:
			movimiento.mov(direction)
	



	#var anim: String
	if velocity.x < 0 : $AnimatedSprite2D.play("walk-left")
	else:
		$AnimatedSprite2D.play("walk-right")

func _on_sensor_body_entered(body):
	player = body


func _on_sensor_body_exited(body):
	player = null
