extends HBoxContainer

# Referencia a la escena del corazón
@onready var HeartGuiClass = preload("res://gui/heartGui.tscn")

# Método llamado cuando el nodo entra en el árbol de escena por primera vez
func _ready():
	pass # No se realiza ninguna acción al entrar en la escena

# Método llamado en cada frame, pero en este caso no se realiza ninguna acción
func _process(delta):
	pass

# Establece el número máximo de corazones en la interfaz de usuario
func setMaxHearts(max: int):
	# Crea instancias de corazones y los agrega como hijos del contenedor
	for i in range(max):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)

# Actualiza la visualización de los corazones según la salud actual del jugador
func updateHearts(currentHealth: int):
	# Obtiene todos los corazones hijos del contenedor
	var hearts = get_children()
	# Actualiza los corazones hasta el número correspondiente a la salud actual
	for i in range(currentHealth):
		hearts[i].update(true)  # Marca el corazón como lleno
	# Desactiva los corazones restantes que no corresponden a la salud actual
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)  # Marca el corazón como vacío
