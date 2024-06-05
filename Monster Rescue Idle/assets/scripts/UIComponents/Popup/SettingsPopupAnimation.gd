extends Control

func _on_close_settings_popup_pressed():
	$SettingsPopupAnimation.play_backwards("popUP")

func _on_setting_button_pressed():
	$SettingsPopupAnimation.play("popUP")
