extends Area2D
class_name hitBox
@export var herida: int = 1
@onready var hurtbox = $HurtBox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#area_entered.connect(golpe)

#func golpe(area):
	#if area.name == "HurtBox":
		#area.daño(herida)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
