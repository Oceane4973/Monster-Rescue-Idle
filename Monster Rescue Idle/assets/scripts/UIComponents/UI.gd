extends CanvasLayer
class_name UI

func _on_close_monsters_popup_pressed():
	$Control/BackgroundPopup.set_visible(false)

func _on_monsters_button_pressed():
	$Control/BackgroundPopup.set_visible(true)

func _on_close_settings_popup_pressed():
	$Control/BackgroundPopup.set_visible(false)

func _on_setting_button_pressed():
	$Control/BackgroundPopup.set_visible(true)

func _on_close_building_popup_pressed():
	$Control/BackgroundPopup.set_visible(false)

func _on_buildings_button_pressed():
	$Control/BackgroundPopup.set_visible(true)
