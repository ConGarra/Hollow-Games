extends Node

@export var speed : int = 100
@export var knockbackPower : int = 1500

var personaje : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func setup(Character2D:CharacterBody2D):
	personaje = Character2D
	
func mov(input_vector: Vector2):
	personaje.velocity = input_vector.normalized() * speed
	personaje.move_and_slide()
	
func parar():
	personaje.velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
