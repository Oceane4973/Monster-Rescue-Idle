extends Control

func _on_close_monsters_popup_pressed():
	$MonstersPopupAnimation.play_backwards("popUP")

func _on_monsters_button_pressed():
	$MonstersPopupAnimation.play("popUP")
