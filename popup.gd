extends Node

@export var spawn_points_parent: Node
@export var demon: Area2D
@export var angel: Area2D
@export var timer: Timer
@export var score_label: Label
@export var health_component: HealthComponent # Drag your HealthComponent here in the Inspector

@onready var spawn_points: Array[Node] = spawn_points_parent.get_children()
var is_visible_phase: bool = false
var score: int = 0

func _ready() -> void:
	set_area_active(demon, false)
	set_area_active(angel, false)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if is_visible_phase:

		if demon.visible and not demon.was_hit:
			if health_component:
				health_component.take_damage(1)
		
		# Turn everything off for the hidden phase
		set_area_active(demon, false)
		set_area_active(angel, false)
		
		is_visible_phase = false
		timer.start(randf_range(0.5, 1.5))
		
	else:
		# --- HIDDEN PHASE IS ENDING -> START VISIBLE PHASE ---
		is_visible_phase = true
		
		var shuffled_points = spawn_points.duplicate()
		shuffled_points.shuffle()
		
		var spawn_demon = randf() < 0.5
		var spawn_angel = randf() < 0.5
		
		if not spawn_demon and not spawn_angel:
			if randf() < 0.5:
				spawn_demon = true
			else:
				spawn_angel = true
		
		if spawn_demon:
			demon.global_position = shuffled_points[0].global_position
			set_area_active(demon, true)
			demon.reset()
		else:
			set_area_active(demon, false)
			
		if spawn_angel:
			var angel_index = 1 if spawn_demon else 0
			angel.global_position = shuffled_points[angel_index].global_position
			set_area_active(angel, true)
			angel.reset()
		else:
			set_area_active(angel, false)
			
		timer.start(1.2)
func set_area_active(area: Area2D, active: bool) -> void:
	area.visible = active
	area.monitoring = active
	area.monitorable = active        

func add_score(points: int) -> void:
	score += points
	if score_label:
		score_label.text = "Score: " + str(score)
