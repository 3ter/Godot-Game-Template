@tool
extends Credits

@export_group("Custom Paths")
## Links to a custom main menu instead of the one set at runtime in project settings.
@export_file("*.tscn") var main_menu_scene : String

func _end_reached():
	%EndMessagePanel.show()
	super._end_reached()

func _on_MenuButton_pressed():
	SceneLoader.load_scene(_get_main_menu())

func _on_ExitButton_pressed():
	get_tree().quit()

func _get_main_menu() -> String:
	return AppConfig.get_main_menu(main_menu_scene)

func _setup_main_menu():
	if _get_main_menu().is_empty():
		%MainMenuButton.hide()

func _ready():
	_setup_main_menu()
	if OS.has_feature("web"):
		%ExitButton.hide()
	super._ready()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if not %EndMessagePanel.visible:
			_end_reached()
		else:
			get_tree().quit()
