extends CharacterBody2D
class_name enemigo

@onready var sensor: Area2D = $"sensor"
@onready var movimiento: Node = $"movimiento"
@onready var player: CollisionObject2D
@onready var effects = $Effects
@onready var hurtTimer = $hurstTimer
@onready var hurtBox = $hurtBox
signal onDead
@export var vida_max = 3
@onready var current_vida : int = vida_max
@export var knockbackPower : int = 1500
var isHurt = false
func _ready():
	movimiento.setup(self)
	

func _physics_process(delta):
	
	if player != null:
		var direction = player.global_position - global_position
		var distancia = global_position.distance_to(player.global_position)
		
		if distancia > 60:
			movimiento.mov(direction)
	
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByPlayer(area)


	#var anim: String
	if velocity.x < 0 : $AnimatedSprite2D.play("walk-left")
	else:
		$AnimatedSprite2D.play("walk-right")

func _on_sensor_body_entered(body):
	player = body


func _on_sensor_body_exited(body):
	player = null

func knockback(enemyVelocity : Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func hurtByPlayer(area):
	# Reduce la salud del jugador en 1
	current_vida -= 1
	
		# Si la salud del jugador es menor que 0, la reinicia a maxHealth
	if current_vida < 0:
		current_vida = vida_max
	# Emite la señal healthChanged con la nueva salud del jugador
	#healthChanged.emit(current_vida)
	isHurt = true
	knockback(area.get_parent().velocity)
	if current_vida <= 0:
		dead()
		return
	effects.play("hustBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false
	
func dead():
	onDead.emit()
	hurtTimer.stop()
	queue_free()
# Método que se activa cuando el jugador entra en una zona


func _on_hurt_box_area_entered(area):
	pass # Replace with function body.


func _on_hurt_box_area_exited(area):
	pass # Replace with function body.
