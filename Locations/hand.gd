extends Node2D

@onready var sprite = $HandSprite

var open_hand
var closed_hand
var start_pos

func _ready():
	open_hand = load("res://Hand/closed_hand.png")
	closed_hand = load("res://Hand/open_hand.png")

	start_pos = sprite.position


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			sprite.texture = closed_hand
			dip_down()
		else:
			sprite.texture = open_hand
			move_back()


func dip_down():
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", start_pos.y + 10, 0.1)


func move_back():
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", start_pos.y, 0.1)
