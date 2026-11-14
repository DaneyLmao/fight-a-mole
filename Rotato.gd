extends Node2D # Works on Sprite2D, CharacterBody2D, etc.

func _input(event: InputEvent) -> void:
	# Replace "ui_accept" with your custom Input Map action
	if event.is_action_pressed("shoot"):
		var tween = create_tween()
		# Rotates +30 degrees from its current angle over 0.5 seconds
		tween.tween_property(self, "rotation_degrees", 30.0, 0.5).as_relative()
