extends CharacterBody2D

# Define la clase Player y declara una señal llamada healthChanged
class_name Player
signal healthChanged

# Declara y exporta la variable maxHealth con un valor predeterminado de 3
@export var maxHealth = 3
# Inicializa la variable currentHealth con el valor de maxHealth
@onready var currentHealth : int = maxHealth
#Iniciamos una variable para llamar al efecto
@onready var effects = $Effects
@onready var hurtTimer = $hurstTimer
@onready var hurtBox = $HurtBox
# Declara y exporta la variable speed con un valor predeterminado de 100
@export var speed : int = 100
@export var knockbackPower : int = 1500

var isHurt: bool = false

func _ready():
	effects.play("RESET")

# Método llamado en cada frame para manejar la física del jugador
func _physics_process(_delta):
	handleInput()
	# Mueve y desliza al jugador
	move_and_slide()
	# Ejecuta las animaciones del jugador
	animaciones()
	# Maneja las colisiones
	handleCollision()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)
	
# Método para manejar las colisiones del jugador
func handleCollision():
	# Itera sobre todas las colisiones en las que está involucrado el jugador
	for i in get_slide_collision_count():
		# Obtiene información sobre la colisión actual
		var collision = get_slide_collision(i)
		# Obtiene el objeto con el que el jugador colisionó
		var collider = collision.get_collider()
		# Imprime el nombre del objeto con el que colisionó el jugador
		print_debug(collider.name)

# Método llamado en cada frame para manejar las entradas del jugador
func handleInput():
	# Detecta las entradas de teclado para determinar la dirección del jugador
	var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	# Calcula la velocidad del jugador según la dirección y la velocidad definidas
	velocity = direction * speed 
	
# Método para manejar las animaciones del jugador
func animaciones():
	# Ejecuta las animaciones correspondientes según las entradas de teclado del jugador
	if (Input.is_action_pressed("derecha")):
		$AnimatedSprite2D.play("walk_right")
	elif (Input.is_action_just_released("derecha")):
		$AnimatedSprite2D.play("qui.derecha")
	elif (Input.is_action_pressed("izquierda")):
		$AnimatedSprite2D.play("walk_left")
	elif (Input.is_action_just_released("izquierda")):
		$AnimatedSprite2D.play("qui.izquierda")
	elif (Input.is_action_pressed("abajo")):
		$AnimatedSprite2D.play("walk_down")
	elif (Input.is_action_just_released("abajo")):
		$AnimatedSprite2D.play("qui.abajo")
	elif (Input.is_action_pressed("arriba")):
		$AnimatedSprite2D.play("walk_up")
	elif (Input.is_action_just_released("arriba")):
		$AnimatedSprite2D.play("qui.arriba")

func hurtByEnemy(area):
	# Reduce la salud del jugador en 1
	currentHealth -= 1
		# Si la salud del jugador es menor que 0, la reinicia a maxHealth
	if currentHealth < 0:
		currentHealth = maxHealth
	# Emite la señal healthChanged con la nueva salud del jugador
		healthChanged.emit(currentHealth)
		isHurt = true
		knockback(area.get_parent().velocity)
		effects.play("hustBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("RESET")
		isHurt = false

# Método que se activa cuando el jugador entra en una zona de daño
func _on_hurt_box_area_entered(area):
	pass
		
		
		
func knockback(enemyVelocity : Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")


func _on_hurt_box_area_exited(area):
	pass
