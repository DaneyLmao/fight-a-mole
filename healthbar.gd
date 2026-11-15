extends HBoxContainer

@export var full_heart: Texture2D
@export var empty_heart: Texture2D

# Now accepts both arguments from the signal
func update_health(current_health: int, _max_health: int) -> void:
	var hearts = get_children()
	for i in range(hearts.size()):
		if i < current_health:
			hearts[i].texture = full_heart
		else:
			hearts[i].texture = empty_heart
