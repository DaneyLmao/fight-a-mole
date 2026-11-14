extends Sprite2D

var flash_tween: Tween

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if flash_tween and flash_tween.is_valid():
			flash_tween.kill()

		global_position = get_global_mouse_position()
		visible = true
		rotation_degrees = randf_range(0.0, 360.0)
		modulate.a = 1.0

		flash_tween = create_tween()
		flash_tween.tween_property(self, "modulate:a", 0.0, 0.1)
		flash_tween.tween_callback(hide)

		_check_hit()

func _check_hit() -> void:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = true

	var results := get_world_2d().direct_space_state.intersect_point(query)
	for result in results:
		var target = result.collider
		if target.is_in_group("targets"):
			target.hit()
