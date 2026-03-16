extends Control

var game_started = false

func _ready():
	if Universal.game_started:
		$btnStart.text = "Continue Experiment"
	else:
		$btnStart.text = "Start Experiment"

func _on_btn_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_btn_end_pressed() -> void:
	$QuitGame.popup_centered()


func _on_quit_game_confirmed() -> void:
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("esc"):
		$QuitGame.popup_centered()


func _on_btn_start_pressed() -> void:
	Universal.game_started = true
	$btnStart.text = "Continue Experiment"
	get_tree().change_scene_to_file("res://Locations/pnlKitchen.tscn")
