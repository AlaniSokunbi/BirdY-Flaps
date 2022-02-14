extends Node




func _on_Play_pressed():
	$CanvasLayer/Control.hide()
	$CanvasLayer/Control/Play.disabled = true
