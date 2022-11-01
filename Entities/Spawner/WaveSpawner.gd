extends Marker2D

@export var mob: PackedScene


func _ready():
	var timer = get_node("Timer")
	timer.start()

func _on_timer_timeout():
	var spawn := mob.instantiate()
	print("spawned", global_position)
	owner.add_child(spawn)
	spawn.global_position = global_position
