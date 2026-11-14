extends Sprite2D

var flash_tween: Tween

func _ready() -> void:
	# Start hidden when the game begins
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		# Reset any active flash so rapid clicks work cleanly
		if flash_tween and flash_tween.is_valid():
			flash_tween.kill()
		
		# 1. Teleport to the cursor and make visible
		global_position = get_global_mouse_position()
		visible = true
		
		# Optional: Add slight random spin and full opacity for variety
		rotation_degrees = randf_range(0.0, 360.0)
		modulate.a = 1.0
		
		# 2. Quickly fade out over 0.1 seconds, then hide
		flash_tween = create_tween()
		flash_tween.tween_property(self, "modulate:a", 0.0, 0.1)
		flash_tween.tween_callback(hide)
