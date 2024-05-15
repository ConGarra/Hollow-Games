extends CharacterBody2D

const speed = 30
var CurrentState = IDLE

var dir = Vector2.RIGHT

var is_roaming = true
var is_chatting = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}
func _ready():
	randomize()

func _process(delta):
	if CurrentState == 0 or CurrentState == 1:
		$AnimatedSprite2D.play("qui.abajo")
		
