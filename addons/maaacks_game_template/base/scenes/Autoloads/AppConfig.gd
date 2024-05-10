extends Node

## Sets a main menu for the project. 
## This helps with testing scenes that skip the main menu.
@export_file("*.tscn") var main_menu_scene : String

func _ready():
	AppLog.app_opened()
	AppSettings.set_from_config_and_window(get_window())
	if not main_menu_scene.is_empty():
		ProjectSettings.set_setting("application/run/main_menu", main_menu_scene)

func get_main_menu(path_override : String):
	if not path_override.is_empty():
		return path_override
	var project_main_menu = ProjectSettings.get_setting("application/run/main_menu")
	if project_main_menu is String:
		return project_main_menu
	return ""
