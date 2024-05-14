extends Area2D
class_name HealthBox

signal OnDead
signal OnDamage
signal onHealthChanged(vida: int)

@export var vida_max = 3
var current_vida:int = vida_max
var antigua_vida: int
# Called when the node enters the scene tree for the first time.
func _ready():
	current_vida = vida_max

func curar(valor: int):
	set_vida(valor)

func daño(herida: int):
	var valor = abs(herida)
	set_vida(-herida)
	
func set_vida(valor: int):
	antigua_vida = current_vida
	current_vida += valor
	current_vida = clamp(current_vida, 0, vida_max)
	
	if antigua_vida != current_vida:
		onHealthChanged.emit(current_vida)
	
	if current_vida <= 0:
		dead()
		return
	elif current_vida >= 0 && current_vida < antigua_vida:
		OnDamage.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dead():
	OnDead.emit()
