extends Node2D

# Referencia al contenedor de corazones en la interfaz de usuario
@onready var heartsContainer = $CanvasLayer/heartsContainer
# Referencia al jugador
@onready var player = $TileMap/player


# Método llamado cuando el nodo entra en el árbol de escena por primera vez
func _ready():
	# Establece el número máximo de corazones en el contenedor según la salud máxima del jugador
	heartsContainer.setMaxHearts(player.vida_max)
	# Actualiza la visualización de los corazones según la salud actual del jugador
	heartsContainer.updateHearts(player.current_vida)
	#Conecta la señal healthChanged del jugador con el método updateHearts del contenedor de corazones
	player.healthChanged.connect(heartsContainer.updateHearts)

# Método llamado en cada frame, pero en este caso no se realiza ninguna acción
func _process(delta):
	pass

func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true
