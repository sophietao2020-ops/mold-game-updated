extends Panel




func _ready() -> void:
	if GlobalVariables.tutorialDone == true:
		$Tutorial.visible = false
		$Tutorial.z_index = -3
	elif GlobalVariables.tutorialSkippedAsk == true and GlobalVariables.tutorialSkipped == false and GlobalVariables.tutorialPart == 0:
		$Tutorial/lblTutorial.text = "now click on the sink!?!"
		$Tutorial/btnSkipTutorialNo.visible = false
		$Tutorial/btnSkipTutorialYes.visible = false
		$btnToTable.visible = false
		$btnToFridge.visible = false
		$btnToCupboard.visible = false
		$btnToDrawer.visible = false
		$btnToSink.visible = true
	elif GlobalVariables.tutorialSkippedAsk == true and GlobalVariables.tutorialSkipped == false and GlobalVariables.tutorialPart == 1:
		$Tutorial/lblTutorial.text = "GO BACK TO THE TABLE."
		$Tutorial/btnSkipTutorialNo.visible = false
		$Tutorial/btnSkipTutorialYes.visible = false
		$btnToTable.visible = true
		$btnToFridge.visible = false
		$btnToCupboard.visible = false
		$btnToDrawer.visible = false
		$btnToSink.visible = false
	else:
		$btnToTable.visible = false
		$btnToFridge.visible = false
		$btnToCupboard.visible = false
		$btnToDrawer.visible = false
		$btnToSink.visible = false
		


func _on_btn_to_fridge_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlFridge.tscn")


func _on_btn_to_cupboard_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlCupboard.tscn")


func _on_btn_to_table_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlTable.tscn")





func _on_btn_to_drawer_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlDrawer.tscn")


func _on_btn_to_sink_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlSink.tscn")


func _on_btn_skip_tutorial_no_pressed() -> void:
	$Tutorial/lblTutorial.text = "Click on the table!!"
	$Tutorial/btnSkipTutorialNo.visible = false
	$Tutorial/btnSkipTutorialYes.visible = false
	GlobalVariables.tutorialSkippedAsk = true
	$btnToTable.visible = true


func _on_btn_skip_tutorial_yes_pressed() -> void:
	$Tutorial/btnSkipTutorialNo.visible = false
	$Tutorial/btnSkipTutorialYes.visible = false
	$Tutorial.visible = false
	GlobalVariables.tutorialSkippedAsk = true
	GlobalVariables.tutorialSkipped = true
	GlobalVariables.tutorialDone = true
	$btnToTable.visible = true
	$btnToFridge.visible = true
	$btnToCupboard.visible = true
	$btnToDrawer.visible = true
	$btnToSink.visible = true

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
