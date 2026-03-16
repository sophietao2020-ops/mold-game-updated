extends Panel


func sync_button_to_global(button, place):
	var item_path = GlobalVariables.drawerItems[place]
	if item_path != null:
		button.texture_normal = load(item_path)
	else:
		button.texture_normal = null

func _ready():
	# Sync the visual buttons with the global data
	sync_button_to_global($btnLocation0, 0)
	sync_button_to_global($btnLocation1, 1)
	sync_button_to_global($btnLocation2, 2)
	sync_button_to_global($btnLocation3, 3)
	sync_button_to_global($btnLocation4, 4)


func handle_location_button(button,place):
	if GlobalVariables.inhand == null:
		if button.texture_normal != null:
			GlobalVariables.inhand = button.texture_normal.resource_path
			GlobalVariables.drawerItems[place] = null
			#change this per scene
			button.texture_normal = null
			# switch place with null, add place to global variable
	else:
		var temp = button.texture_normal
		GlobalVariables.drawerItems[place] = GlobalVariables.inhand
		#change this per scene
		button.texture_normal = load(GlobalVariables.inhand)
		
		if temp != null:
			GlobalVariables.inhand = temp.resource_path
		else:
			GlobalVariables.inhand = null

func _on_btn_location_1_pressed() -> void:
	handle_location_button($btnLocation1,1)


func _on_btn_location_2_pressed() -> void:
	handle_location_button($btnLocation2,2)


func _on_btn_location_3_pressed() -> void:
	handle_location_button($btnLocation3,3)


func _on_btn_location_0_pressed() -> void:
	handle_location_button($btnLocation0,0)





func _on_btn_to_kitchen_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlKitchen.tscn")


func _on_btn_location_4_pressed() -> void:
	handle_location_button($btnLocation4,4)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var paused = !get_tree().paused
	get_tree().paused = paused
	$PauseMenu.visible = paused

func _on_btn_resume_pressed() -> void:
	get_tree().paused = false
	$PauseMenu.visible = false


func _on_btn_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _on_pause_button_pressed() -> void:
	toggle_pause()
