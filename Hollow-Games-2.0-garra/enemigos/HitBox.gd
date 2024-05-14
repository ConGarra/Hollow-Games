extends Area2D
class_name HitBox
@export var herida: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(golpe)

func golpe(area):
	if area is HealthBox:
		area.daño(herida)
		print_debug("pene")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass