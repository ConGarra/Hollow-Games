extends CharacterBody2D

# Define la clase Player y declara una señal llamada healthChanged
class_name Player
signal healthChanged

# Declara y exporta la variable maxHealth con un valor predeterminado de 3
@export var vida_max = 3
#Inicializa la variable currentHealth con el valor de maxHealth
@onready var current_vida : int = vida_max
#Iniciamos una variable para llamar al efecto
@onready var effects = $Effects
@onready var hurtTimer = $hurstTimer
@onready var hurtBox = $HurtBox
@onready var spr = $Sprite2D
@onready var AnimationSprite = $AnimatedSprite2D
# Declara y exporta la variable speed con un valor predeterminado de 100
@export var speed : int = 300
@export var knockbackPower : int = 1500

@export var inventory: Inventory

@onready var ata: AnimationPlayer = $"ataas"



signal onDead
var ultimaDir: String = ""
var taAtacando: bool
var isHurt: bool = false
var can_move: bool = true  # Variable para controlar si el jugador puede moverse.
var ultimaCam: String = "-arriba"
func _ready():
	effects.play("RESET")
	
		
# Método llamado en cada frame para manejar la física del jugador
func _physics_process(_delta):
	if can_move:  # Verifica si el jugador puede moverse
		handleInput()
	# Mueve y desliza al jugador
	
	move_and_slide()
	# Ejecuta las animaciones del jugador
	animaciones()
	ataq()
	# Maneja las colisiones
	handleCollision()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)
# Animaciones de ataque
func ataq():
	if Input.is_action_just_pressed("swing"):
		var dirAtaque: String
		if taAtacando: return
		
		if  velocity.x == 0 && velocity.y == 0: 
			dirAtaque = ultimaCam
			
		elif velocity.x < 0 : dirAtaque = "-izquierda"
		elif velocity.y < 0 : dirAtaque = "-arriba"
		elif velocity.y > 0 : dirAtaque = "-abajo"
		elif velocity.x > 0 : dirAtaque = "-derecha"
		if dirAtaque != "":
			AnimationSprite.visible = false
			spr.visible = true
			var ataque = "ataque" + dirAtaque
			ata.play(ataque)
			
		else:
			dirAtaque = ultimaCam
			AnimationSprite.visible = false
			spr.visible = true
			var ataque = "ataque" + dirAtaque
			ata.play(ataque)
			
		
			
			
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
	
	if Input.is_action_just_pressed("swing"):
		var ataque = "ataque" + ultimaCam
		ata.play(ataque)
		taAtacando = true
		await ata.animation_finished
		taAtacando = false
		
# Método llamado en cada frame para manejar las entradas del jugador
func handleInput():
	# Detecta las entradas de teclado para determinar la dirección del jugador
	var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	# Calcula la velocidad del jugador según la dirección y la velocidad definidas
	velocity = direction * speed 
	
	

# Método para manejar las animaciones del jugador
func animaciones():
	 #Ejecuta las animaciones correspondientes según las entradas de teclado del jugador
	if (Input.is_action_pressed("derecha")):
		AnimationSprite.play("andar_derecha")
		ultimaCam = "-derecha"
		
	elif (Input.is_action_pressed("izquierda")):
		AnimationSprite.play("andar_izquierda")
		ultimaCam = "-izquierda"
	
	elif (Input.is_action_pressed("abajo")):
		AnimationSprite.play("andar_abajo")
		ultimaCam = "-abajo"
	
	elif (Input.is_action_pressed("arriba")):
		AnimationSprite.play("andar_arriba")
		ultimaCam = "-arriba"
	
	elif velocity.x == 0 || velocity.y == 0:
		AnimationSprite.set_frame(0)
	

func hurtByEnemy(area):
	# Reduce la salud del jugador en 1
	current_vida -= 1
		# Si la salud del jugador es menor que 0, la reinicia a maxHealth
	if current_vida < 0:
		current_vida = vida_max
	# Emite la señal healthChanged con la nueva salud del jugador
	healthChanged.emit(current_vida)
	isHurt = true
	knockback(area.get_parent().velocity)
	if current_vida <= 0:
		dead()
		$"Camera2D/Has-Muerto".visible = true
		return
	effects.play("hustBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false
	
func dead():
	onDead.emit()
	queue_free()
# Método que se activa cuando el jugador entra en una zona
func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	
func knockback(enemyVelocity : Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _on_hurt_box_area_exited(area):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ataque-arriba":
			AnimationSprite.visible = true
			spr.visible  = false
	elif anim_name == "ataque-abajo":
			AnimationSprite.visible = true
			spr.visible  = false
	elif anim_name == "ataque-derecha":
			AnimationSprite.visible = true
			spr.visible  = false
	elif anim_name == "ataque-izquierda":
			AnimationSprite.visible = true
			spr.visible  = false
	
#Relacionado con SapitoNpc
func player():
	pass
	
	
