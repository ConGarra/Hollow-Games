extends CharacterBody2D  # Extiende la clase CharacterBody2D, utilizada para personajes que se mueven en un juego 2D.

var CurrentState = IDLE  # Variable que guarda el estado actual del personaje, inicializado en IDLE.
var is_roaming = true  # Variable booleana que indica si el personaje está en modo de patrullaje.
var is_chatting = false  # Variable booleana que indica si el personaje está en modo de charla.

var player_in_area = false  # Variable booleana que indica si el jugador está en el área de interacción.

# Enum que define los posibles estados del personaje.
enum {
	IDLE,  # Estado en reposo.
}

func _ready():  # Función llamada al inicio, cuando el nodo está listo.
	randomize()  # Inicializa el generador de números aleatorios.
	Dialogic.signal_event.connect(DialogicSignal)  # Conecta la señal de Dialogic a la función DialogicSignal.

func _process(delta):  # Función que se llama cada frame.
		if player_in_area:  # Si el jugador está en el área de interacción.
			if Input.is_action_just_pressed("e"):  # Si se presiona la tecla "e".
				run_dialogue("sapitoTimeline")  # Inicia el diálogo con el ID "sapitoTimeline".
		if CurrentState == 0:  # Si el estado actual es IDLE.
			$AnimatedSprite2D.play("qui.abajo")  # Reproduce la animación "qui.abajo".

func run_dialogue(dialogue_string):  # Función para iniciar un diálogo.
	is_chatting = true  # Establece que el personaje está charlando.
	is_roaming = false  # Detiene el patrullaje.
	Dialogic.start(dialogue_string)  # Inicia el diálogo con el string proporcionado.
	# Encuentra el nodo del jugador
	var player = get_node("../player")  # Ajusta la ruta al nodo del jugador
	if player:
		player.can_move = false  # Deshabilita el movimiento del jugador
	Dialogic.start(dialogue_string)  # Inicia el diálogo con el string proporcionado.
	
func DialogicSignal(arg : String):  # Función llamada cuando se recibe una señal de Dialogic.
	if arg == "exit_sapito":
		print("signal received")
		is_chatting = false
		is_roaming = true
		
		# Encuentra el nodo del jugador
		var player = get_node("../player")  # Ajusta la ruta al nodo del jugador
		if player:
			player.can_move = true  # Habilita el movimiento del jugador

func choose(array):  # Función para elegir aleatoriamente un elemento de una lista.
	array.shuffle()  # Mezcla el array.
	return array.front()  # Devuelve el primer elemento del array mezclado.

func _on_detecion_dialogo_body_entered(body):  # Función llamada cuando un cuerpo entra en el área de detección.
	if body.has_method("player"):  # Si el cuerpo tiene el método "player" (indicando que es el jugador).
		player_in_area = true  # Establece que el jugador está en el área de interacción.

func _on_detecion_dialogo_body_exited(body):  # Función llamada cuando un cuerpo sale del área de detección.
	if body.has_method("player"):  # Si el cuerpo tiene el método "player" (indicando que es el jugador).
		player_in_area = false  # Establece que el jugador ya no está en el área de interacción.
