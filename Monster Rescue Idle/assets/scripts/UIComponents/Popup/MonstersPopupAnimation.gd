extends CanvasLayer

func _on_close_monsters_popup_pressed():
	$Control/MonstersPopupAnimation.play_backwards("popUP")

func _on_monsters_button_pressed():
	$Control/MonstersPopupAnimation.play("popUP")
