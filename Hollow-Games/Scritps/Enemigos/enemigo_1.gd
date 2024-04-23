extends CharacterBody2D

@export var speed  = 110
@export var limit = 1 
@onready var animations = $AnimatedSprite2D
@export var endPoint: Marker2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * speed
func updateAnimation():
	var animationString = "walk_up"
	if velocity.y > 0:
		animationString = "walk_down"
	animations.play(animationString)
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
