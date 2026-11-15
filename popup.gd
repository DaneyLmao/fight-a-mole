extends Node

@export var spawn_points_parent: Node
@export var demon: Area2D
@export var angel: Area2D
@export var timer: Timer

@onready var spawn_points: Array[Node] = spawn_points_parent.get_children()
var is_visible_phase: bool = false

func _ready() -> void:
	set_area_active(demon, false)
	set_area_active(angel, false)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	is_visible_phase = !is_visible_phase
	
	if is_visible_phase:
		var shuffled_points = spawn_points.duplicate()
		shuffled_points.shuffle()
		
		# Added [0] and [1] to pick the first two shuffled markers
		demon.global_position = shuffled_points[0].global_position
		angel.global_position = shuffled_points[1].global_position
		
		set_area_active(demon, true)
		set_area_active(angel, true)
		timer.start(1.2)
		angel.reset()
		demon.reset()
	else:
		set_area_active(demon, false)
		set_area_active(angel, false)
		timer.start(randf_range(0.5, 1.5))

func set_area_active(area: Area2D, active: bool) -> void:
	area.visible = active
	area.monitoring = active
	area.monitorable = active        
	
@export var score_label: Label
var score: int = 0

func add_score(points: int) -> void:
	score += points
	score_label.text = "Score: " + str(score)
