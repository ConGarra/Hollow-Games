extends CharacterBody2D
#
class_name Player
signal healthChanged

var direction : Vector2 = Vector2.ZERO

@export var maxHealth = 3
@onready var currentHealth : int = maxHealth


@export var speed : int = 100

func _physics_process(_delta):
	velocity = direction * speed
	move_and_slide()
	animaciones()
	handleCollision()
	
	
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _process(_delta):
	direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo") 
	
func animaciones():
	#-------------------------DERECHA--------------------
	if (Input.is_action_pressed("derecha")):
		$AnimatedSprite2D.play("walk_right")
		
	elif (Input.is_action_just_released("derecha")):
		$AnimatedSprite2D.play("qui.derecha")
	#--------------------------IZQUIERDA------------------
	elif (Input.is_action_pressed("izquierda")):
		$AnimatedSprite2D.play("walk_left")
		
	elif (Input.is_action_just_released("izquierda")):
		$AnimatedSprite2D.play("qui.izquierda")
	#--------------------------ABAJO------------------------
	elif (Input.is_action_pressed("abajo")):
		$AnimatedSprite2D.play("walk_down")
	
	elif (Input.is_action_just_released("abajo")):
		$AnimatedSprite2D.play("qui.abajo")
		#---------------------------ARRIBA---------------------
	elif (Input.is_action_pressed("arriba")):
		$AnimatedSprite2D.play("walk_up")
	elif (Input.is_action_just_released("arriba")):
		$AnimatedSprite2D.play("qui.arriba")

	

func _on_hurt_box_area_entered(area):
	if area.name == "HitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
