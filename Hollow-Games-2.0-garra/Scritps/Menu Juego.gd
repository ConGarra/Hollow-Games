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
