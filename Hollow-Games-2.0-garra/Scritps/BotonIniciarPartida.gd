extends Button


func _on_pressed():
	get_tree().change_scene_to_file("res://Escenarios/escenario_principal.tscn")


func _on_salir_pressed():
	get_tree().quit()



func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Escenarios/Menu_Opciones.tscn")
