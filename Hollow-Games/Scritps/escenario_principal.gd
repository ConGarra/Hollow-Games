extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/player

# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
