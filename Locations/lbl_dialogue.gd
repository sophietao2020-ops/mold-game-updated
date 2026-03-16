extends Label

var current_tween: Tween

@export var type_speed: float = 0.1
@export var erase_speed: float = 0.02
@export var pause_time: float = 4

func display_text(new_text: String):
	if current_tween:
		current_tween.kill()
	text = new_text
	visible_characters = 0
	current_tween = create_tween()
	var total_chars = text.length()
	current_tween.tween_property(self, "visible_characters", total_chars, total_chars * type_speed)
	current_tween.tween_interval(pause_time)
	current_tween.tween_property(self, "visible_characters", 0, total_chars * erase_speed)
