extends Panel

func sync_button_to_global(button, place):
	var item_path = GlobalVariables.sinkItems[place]
	if item_path != null:
		button.texture_normal = load(item_path)
	else:
		button.texture_normal = null

func _ready():
	if GlobalVariables.tutorialDone == true:
		$Tutorial.visible = false
		$Tutorial.z_index = -3
		$btnLocation1.visible = true
		$btnLocation2.visible = true
		$btnLocation4.visible = true
		$btnLocation3.visible = true
	else:
		$btnLocation1.visible = false
		$btnLocation2.visible = false
		$btnLocation4.visible = false
		$btnToKitchen.disabled = true
	sync_button_to_global($btnLocation1, 0)
	sync_button_to_global($btnLocation2, 1)
	sync_button_to_global($btnLocation3, 2)
	sync_button_to_global($btnLocation4, 3)


func handle_location_button(button,place):
	if GlobalVariables.inhand == null:
		if button.texture_normal != null:
			GlobalVariables.inhand = button.texture_normal.resource_path
			GlobalVariables.sinkItems[place] = null
			#change this per scene
			button.texture_normal = null
			# switch place with null, add place to global variable
	else:
		var temp = button.texture_normal
		GlobalVariables.sinkItems[place] = GlobalVariables.inhand
		#change this per scene
		button.texture_normal = load(GlobalVariables.inhand)
		
		if temp != null:
			GlobalVariables.inhand = temp.resource_path
		else:
			GlobalVariables.inhand = null




func _on_btn_to_kitchen_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlKitchen.tscn")


func _on_btn_location_1_pressed() -> void:
	handle_location_button($btnLocation1,0)

func _on_btn_location_2_pressed() -> void:
	handle_location_button($btnLocation2,1)


func _on_btn_location_3_pressed() -> void:
	if GlobalVariables.tutorialDone == false:
		$Tutorial/lblTutorial.text = "Go back to the table!"
		$btnLocation3.disabled = true
		$btnToKitchen.disabled = false
		GlobalVariables.tutorialPart = 1
	handle_location_button($btnLocation3,2)


func _on_btn_location_4_pressed() -> void:
	handle_location_button($btnLocation4,3)


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
