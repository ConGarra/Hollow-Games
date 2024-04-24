extends CharacterBody2D

# Velocidad del movimiento del personaje
@export var speed = 110
# Límite de distancia para cambiar de dirección
@export var limit = 1 
# Referencia al AnimatedSprite2D para reproducir animaciones
@onready var animations = $AnimatedSprite2D
# Punto final al que el personaje se dirige
@export var endPoint: Marker2D

# Posición inicial y final del movimiento
var startPosition
var endPosition

func _ready():
	# Al inicio, se establecen las posiciones inicial y final
	startPosition = position
	endPosition = endPoint.global_position
	
# Cambia la dirección del movimiento intercambiando las posiciones inicial y final
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
# Calcula y actualiza la velocidad del personaje
func updateVelocity():
	# Calcula el vector de dirección hacia el punto final
	var moveDirection = endPosition - position
	# Si la distancia al punto final es menor que el límite establecido
	if moveDirection.length() < limit:
		# Cambia la dirección del movimiento
		changeDirection()
	# Actualiza la velocidad del personaje para moverlo hacia el punto final
	velocity = moveDirection.normalized() * speed

# Actualiza la animación del personaje según su velocidad
func updateAnimation():
	# Determina la animación basada en la dirección del movimiento
	var animationString = "walk_up"
	if velocity.y > 0:
		animationString = "walk_down"
	# Reproduce la animación correspondiente
	animations.play(animationString)

# Método llamado en cada frame para actualizar la física y la animación del personaje
func _physics_process(delta):
	# Actualiza la velocidad del personaje
	updateVelocity()
	# Mueve y desliza al personaje
	move_and_slide()
	# Actualiza la animación del personaje
	updateAnimation()
