extends CanvasLayer

func _on_close_settings_popup_pressed():
	$Control/SettingsPopupAnimation.play_backwards("popUP")

func _on_setting_button_pressed():
	$Control/SettingsPopupAnimation.play("popUP")
