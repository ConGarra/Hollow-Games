extends Control


func _on_check_pantalla_completa_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	
	$HBoxContainer/Check/Check_Sin_Bordes.button_pressed = false
	$HBoxContainer/Check/Check_VSync.button_pressed = false
func _on_check_sin_bordes_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	$HBoxContainer/Check/Check_Pantalla_Completa.button_pressed = false
	$HBoxContainer/Check/Check_VSync.button_pressed = false

func _on_check_v_sync_toggled(button_pressed):
	DisplayServer.window_get_vsync_mode(DisplayServer.VSYNC_ENABLED)
	
	
	$HBoxContainer/Check/Check_Sin_Bordes.button_pressed = false
	$HBoxContainer/Check/Check_Pantalla_Completa.button_pressed = false


