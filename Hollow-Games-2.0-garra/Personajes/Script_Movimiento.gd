extends CharacterBody2D

@export var velocidad : int = 500

func _physics_process(delta: float) -> void:
	movimiento()

func movimiento():
	velocity = Input.get_vector("izquierda", "derecha", "arriba", "abajo") * velocidad
	move_and_slide()
