extends Control

signal openedm
signal closedm
var isOpenm = true

func open():
	visible = true
	isOpenm = true
	openedm.emit()

func close():
	visible = false
	isOpenm = false
	closedm.emit()


func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenarios/menu_opciones_juego.tscn")


func _on_menu_principal_pressed():
	get_tree().change_scene_to_file("res://Escenarios/menu_principal.tscn")


func _on_atras_pressed():
	print_debug("presionado")
	closedm.emit()
	visible = false
