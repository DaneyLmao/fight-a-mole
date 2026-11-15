extends Area2D

@export var spawn_cycle: Node
@export var point_value: int = 10 # Set to positive for Angel, negative for Demon

func hit() -> void:
	print("You Fucking Dumbass${point_value}")
	if spawn_cycle:
		spawn_cycle.add_score(point_value)
	
	hide()
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	$CollisionShape2D.set_deferred("disabled", true)
