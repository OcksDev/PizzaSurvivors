extends MenuButton

@export var menu_scene = "res://scenes/menu/main_menu.tscn"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS# Get the menu options when it pops up
	var menu = get_popup()
	menu.connect("id_pressed", Callable(self, "_on_menu_item_pressed"))

func _on_pressed() -> void:
	MenuPageChangeSound.play()
	
	if self.text == "Pause":
		get_tree().paused = true
		self.text = "Resume"
		
	elif self.text == "Resume":
		get_tree().paused = false
		self.text = "Pause"

func _on_menu_item_pressed(id):
	match id:
		0: # Menu
			get_tree().paused = false
			get_tree().change_scene_to_file(menu_scene)
			MenuPageChangeSound.play()
		1: # Quit
			get_tree().quit()
