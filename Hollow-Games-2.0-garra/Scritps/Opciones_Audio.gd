extends Control

func _on_h_slider_volumen_principal_value_changed(value):
	volume(0, value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)


func _on_h_slider_2_volumen_musica_value_changed(value):
	volume(1, value)


func _on_h_slider_3_sonido_fx_value_changed(value):
	volume(2, value)
