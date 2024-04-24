extends CharacterBody2D

# Define la clase Player y declara una señal llamada healthChanged
class_name Player
signal healthChanged

# Define la dirección del jugador como Vector2.ZERO (ninguna dirección)
var direction : Vector2 = Vector2.ZERO

# Declara y exporta la variable maxHealth con un valor predeterminado de 3
@export var maxHealth = 3
# Inicializa la variable currentHealth con el valor de maxHealth
@onready var currentHealth : int = maxHealth

# Declara y exporta la variable speed con un valor predeterminado de 100
@export var speed : int = 100

# Método llamado en cada frame para manejar la física del jugador
func _physics_process(_delta):
	# Calcula la velocidad del jugador según la dirección y la velocidad definidas
	velocity = direction * speed
	# Mueve y desliza al jugador
	move_and_slide()
	# Ejecuta las animaciones del jugador
	animaciones()
	# Maneja las colisiones
	handleCollision()
	
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
func _process(_delta):
	# Detecta las entradas de teclado para determinar la dirección del jugador
	direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo") 
	
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

# Método que se activa cuando el jugador entra en una zona de daño
func _on_hurt_box_area_entered(area):
	# Verifica si la zona de daño es la HitBox
	if area.name == "HitBox":
		# Reduce la salud del jugador en 1
		currentHealth -= 1
		# Si la salud del jugador es menor que 0, la reinicia a maxHealth
		if currentHealth < 0:
			currentHealth = maxHealth
		# Emite la señal healthChanged con la nueva salud del jugador
		healthChanged.emit(currentHealth)
