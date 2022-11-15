extends Marker2D

@export var mob: PackedScene
@export var spawn_timer: float = 3.0
@export var y_range: float = 10.0

func _ready():
	var timer: Timer = get_node("Timer")
	timer.wait_time = spawn_timer
	timer.start()

func _on_timer_timeout():
	var spawn := mob.instantiate()
	owner.add_child(spawn)
	spawn.global_position = global_position + Vector2(0, randf_range(-y_range, y_range))
 
