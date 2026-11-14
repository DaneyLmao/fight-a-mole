extends Sprite2D

@export var target_min: Vector2 = Vector2(-50, -50) # Small frame min
@export var target_max: Vector2 = Vector2(50, 50)   # Small frame max

var anchor_position: Vector2

func _ready() -> void:
	anchor_position = global_position

func _process(delta: float) -> void:
	var viewport_size = get_viewport_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Map screen coordinates (0 to viewport_size) to the smaller range
	var mapped_x = remap(mouse_pos.x, 0.0, viewport_size.x, target_min.x, target_max.x)
	var mapped_y = remap(mouse_pos.y, 0.0, viewport_size.y, target_min.y, target_max.y)
	
	# Clamp ensures it stays inside even if the mouse leaves the window
	mapped_x = clamp(mapped_x, target_min.x, target_max.x)
	mapped_y = clamp(mapped_y, target_min.y, target_max.y)
	
	global_position = anchor_position + Vector2(mapped_x, mapped_y)
