extends Control


func _on_check_pantalla_completa_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_check_sin_bordes_toggled(button_pressed):
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_check_v_sync_toggled(button_pressed):
	DisplayServer.window_get_vsync_mode(DisplayServer.VSYNC_ENABLED)
