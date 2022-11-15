extends NecromancerState

var move_direction: Vector2 = Vector2.ZERO


func arrived_at_location() -> bool:
	return reference.navigation_agent.is_navigation_finished()

func set_target_location(target: Vector2) -> void:
	reference.navigation_agent.set_target_location(target)

func set_chasing_target_and_transition(target):
	state_machine.transition_to("Chase", {"target": target})

func physics_update(_delta: float) -> void:
	move_direction = reference.position.direction_to(reference.navigation_agent.get_next_location())
	reference.velocity = move_direction * reference.stats.speed
	reference.navigation_agent.set_velocity(reference.velocity)
	
	if move_direction.x > 0:
		reference.set_scale(Vector2(1, 1))
		reference.rotation = deg_to_rad(0)
	elif move_direction.x < 0:
		reference.scale = Vector2(1, -1)
		reference.rotation = deg_to_rad(180)

	if not arrived_at_location():
		reference.move_and_slide()
	else:
		reference.queue_free()
			

func enter(_msg := {}) -> void:
	reference._play_animation("Run")
	reference.navigation_agent.set_target_location(reference.goal)

