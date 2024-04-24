extends Panel

# Referencia al Sprite2D que representa el corazón
@onready var sprite = $Sprite2D

# Método llamado cuando el nodo entra en el árbol de escena por primera vez
func _ready():
	pass  # No se realiza ninguna acción al entrar en la escena

# Método llamado en cada frame, pero en este caso no se realiza ninguna acción
func _process(delta):
	pass

# Actualiza el sprite del corazón para mostrarlo lleno o vacío según el parámetro 'whole'
func update(whole: bool):
	if whole:
		sprite.frame = 0  # Establece el frame del sprite para mostrar el corazón lleno
	else:
		sprite.frame = 6  # Establece el frame del sprite para mostrar el corazón vacío
