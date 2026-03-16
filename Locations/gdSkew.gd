extends Sprite2D

func trigger_skew_effect(duration: float, swings: int, intensity_multiplier: float, is_increasing: bool):
	var tween = create_tween()
	
	for i in range(swings):
		# Calculate the current "progress" (0.0 to 1.0)
		var progress = float(i) / float(swings - 1)
		
		# Determine intensity based on the boolean
		var current_intensity = intensity_multiplier
		if is_increasing:
			current_intensity *= progress
		else:
			current_intensity *= (1.0 - progress)
			
		# Alternate side (Left/Right)
		var target_skew = current_intensity if i % 2 == 0 else -current_intensity
		
		# Add the tween step
		tween.tween_property(self, "skew", target_skew, duration / swings)\
			 .set_trans(Tween.TRANS_SINE)\
			 .set_ease(Tween.EASE_IN_OUT)
	
	# Reset to neutral
	tween.tween_property(self, "skew", 0.0, 0.1)
