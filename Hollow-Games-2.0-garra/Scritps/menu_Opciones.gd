extends Button



func _on_audio_pressed():
	get_tree().change_scene_to_file("res://Escenarios/Opciones_Audio.tscn")
	
	


func _on_atras_pressed():
	get_tree().change_scene_to_file("res://Escenarios/menu_principal.tscn")


func _on_pressed():
	get_tree().change_scene_to_file("res://Escenarios/Opciones_Video.tscn")
