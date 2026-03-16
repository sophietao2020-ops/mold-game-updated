extends Panel

func sync_button_to_global(button, place):
	var item_path = GlobalVariables.tableItems[place]
	if item_path != null:
		button.texture_normal = load(item_path)
	else:
		button.texture_normal = null

func _ready():
	if GlobalVariables.tutorialDone == true:
		$Tutorial.visible = false
		$Tutorial.z_index = -3
	elif GlobalVariables.tutorialPart == 1:
		$Tutorial/lblTutorial.text = """your mold is thirsty.
		click it to feed it!!"""
		$btnLocation0.visible = false
		$btnLocation1.visible = false
		$btnLocation2.visible = false
		$btnLocation3.visible = false
		$btnToKitchen.disabled = true
	
	# Sync the visual buttons with the global data
	sync_button_to_global($btnLocation0, 0)
	sync_button_to_global($btnLocation1, 1)
	sync_button_to_global($btnLocation2, 2)
	sync_button_to_global($btnLocation3, 3)
	$nodMold/Sprite2D.texture = load(GlobalVariables.moldType[0])
	

func handle_location_button(button,place):
	if GlobalVariables.inhand == null:
		if button.texture_normal != null:
			GlobalVariables.inhand = button.texture_normal.resource_path
			GlobalVariables.tableItems[place] = null
			#change this per scene
			button.texture_normal = null
			# switch place with null, add place to global variable
	else:
		var temp = button.texture_normal
		GlobalVariables.tableItems[place] = GlobalVariables.inhand
		#change this per scene
		button.texture_normal = load(GlobalVariables.inhand)
		
		if temp != null:
			GlobalVariables.inhand = temp.resource_path
		else:
			GlobalVariables.inhand = null


func feedType(foodType): #ensures if mold is advanced can opnly eat acceptable food
	var _item_type = GlobalVariables.propertyItems.get(GlobalVariables.inhand)
	
	GlobalVariables.eatenItems[foodType] += 1
	print("ate: ", GlobalVariables.inhand)
	print(foodType,GlobalVariables.eatenItems[foodType])
	
	#Clear the hand
	GlobalVariables.inhand = null
	
func checkLevel(foodType,levelCheck,moldLevelCheck):
	if GlobalVariables.eatenItems[foodType] == levelCheck:
		GlobalVariables.moldType[1] = moldLevelCheck
		GlobalVariables.moldType[0] = "res://MoldStages/"+foodType+str(levelCheck)+".PNG"
		levelUpMold()
		#$nodMold/Sprite2D.texture = load(GlobalVariables.moldType[0])
	
func levelUpMold():
	$btnToKitchen.disabled = true
	$nodMold/Sprite2D.trigger_skew_effect(2,10,1,true)
	await get_tree().create_timer(2).timeout
	$nodMold/Sprite2D.texture = load(GlobalVariables.moldType[0])
	$nodMold/Sprite2D.trigger_skew_effect(2,10,1,false)
	$btnToKitchen.disabled = false


func _on_btn_to_kitchen_pressed() -> void:
	get_tree().change_scene_to_file("res://Locations/pnlKitchen.tscn")


func _on_btn_feed_mold_pressed() -> void:
	var arrFood = ["Mmmm, delicous absolutly fantastic.", "I'm taking a liking to the HUMAN food.", "Why is it crunchy?", "What a Peculiar sensation!","This fully sates my hunger. I am in satisfaction."]
	var arrMetal = ["This leaves a metallic aftertaste.","I do like this shiny stuff", "My hunger is insatiable. Feed me MORE.","Structural integrity detected. High-density caloric yield.","""print("01100010 01100101 01100101 01110000")"""]
	var arrOther = ["Is this what HUMANS call 'spicy'?","This leaves a distastful aftertaste...","I can see the stars","I shall frost this under my breath", "Knowledge beckons me.","I understand it now, the universe and all of its answers."]
	if GlobalVariables.inhand == null: #check null
		print("Nothing to feed!")
		return
	if GlobalVariables.inhand == "res://Items/water.PNG":
		
		$Tutorial/lblTutorial.text= """The tutorial is done!
		collect more items!!"""
		GlobalVariables.tutorialDone = true
		$btnToKitchen.disabled = false
	# Check if the item exists in properties
	
	var item_type = GlobalVariables.propertyItems.get(GlobalVariables.inhand)
	
	if GlobalVariables.moldType[1] == "Basic":
		if item_type == "Food":
			GlobalVariables.eatenItems["Food"] += 1
			print("ate: ", GlobalVariables.inhand)
			print("food",GlobalVariables.eatenItems["Food"])
			checkLevel("Food",3,"Food")
			#add when food mold level implemented
			#Clear the hand
			GlobalVariables.inhand = null
			$lblDialogue.display_text(arrFood[GlobalVariables.eatenItems["Food"]-1])
		elif item_type == "Metal":
			GlobalVariables.eatenItems["Metal"] += 1
			print("ate: ", GlobalVariables.inhand)
			print("metal",GlobalVariables.eatenItems["Metal"])
			checkLevel("Metal",3,"Metal")
			$lblDialogue.display_text(arrMetal[GlobalVariables.eatenItems["Metal"]-1])
			GlobalVariables.inhand = null
		elif item_type == "Other":
			GlobalVariables.eatenItems["Other"] += 1
			print("ate: ", GlobalVariables.inhand)
			print("Other",GlobalVariables.eatenItems["Other"])
			checkLevel("Other",4,"Other")
			$lblDialogue.display_text(arrOther[GlobalVariables.eatenItems["Other"]-1])
			GlobalVariables.inhand = null
		else:
			print("cant eat", item_type)
	elif GlobalVariables.moldType[1] == "Metal":
		if item_type == "Metal":
			feedType("Metal")
			checkLevel("Metal",5,"LargeMetal")
			$lblDialogue.display_text(arrMetal[GlobalVariables.eatenItems["Metal"]-1])
		else:
			$lblDialogue.display_text("CANT EAT THIS > TRY AGAIN")
			pass
	elif GlobalVariables.moldType[1] == "Other":
		if item_type == "Other":
			feedType("Other")
			checkLevel("Other",6,"LargeOther")
			$lblDialogue.display_text(arrOther[GlobalVariables.eatenItems["Other"]-1])
		else:
			$lblDialogue.display_text("Apologies I can't eat this...")
			pass
	elif GlobalVariables.moldType[1] == "Food":
		if item_type == "Food":
			feedType("Food")
			checkLevel("Food",5,"LargeFood")
			$lblDialogue.display_text(arrOther[GlobalVariables.eatenItems["Food"]-1])
		else:
			$lblDialogue.display_text("I can only eat items with nutrition now...")
			pass

func _on_btn_location_0_pressed() -> void:
	handle_location_button($btnLocation0,0)


func _on_btn_location_1_pressed() -> void:
	handle_location_button($btnLocation1,1)


func _on_btn_location_2_pressed() -> void:
	handle_location_button($btnLocation2,2)


func _on_btn_location_3_pressed() -> void:
	handle_location_button($btnLocation3,3)


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
