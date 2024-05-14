extends Area2D

@export var herida: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(golpe)

func golpe(area):
	if area is HealthBox:
		area.daño(herida)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
