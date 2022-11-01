extends SkeletonState

signal goal_reached
signal target_reached(target)

var move_direction: Vector2 = Vector2.ZERO
var did_arrive: bool = false
var is_chasing: bool = false
var delta_pos: float = 0

func physics_update(_delta: float) -> void:
	if reference.ally_detection_zone.in_range():
		var hitbox_pos: Vector2 = reference.get_node("SwordHitBox").get_node("CollisionShape2d").position
		delta_pos =  reference.position.x - reference.ally_detection_zone.allies[0].global_position.x
		if delta_pos >= 0:
			reference.set_target_location(reference.ally_detection_zone.allies[0].global_position + Vector2(hitbox_pos.x*2, 0))
		else:
			reference.set_target_location(reference.ally_detection_zone.allies[0].global_position - Vector2(hitbox_pos.x*2, 0))
	else:
		reference.set_target_location(reference.goal)

	move_direction = reference.position.direction_to(reference.navigation_agent.get_next_location())
	reference.velocity = move_direction * reference.stats.speed
	reference.navigation_agent.set_velocity(reference.velocity)
	
	if move_direction.x > 0:
		reference.set_scale(Vector2(1, 1))
		reference.rotation = deg_to_rad(0)
	elif move_direction.x < 0:
		reference.scale = Vector2(1, -1)
		reference.rotation = deg_to_rad(180)


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	did_arrive = false
	is_chasing = false
	reference._play_animation("Run")


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	reference.velocity = safe_velocity
	if not reference._arrived_at_location():
		reference.move_and_slide()
	elif not did_arrive:
		did_arrive = true
		if reference.navigation_agent.get_target_location() == reference.goal:
			emit_signal("goal_reached")
			reference.queue_free()
		else:
			emit_signal("target_reached", reference.ally_detection_zone.allies[0])
			# Reajust orientation before hiting
			if delta_pos < 0:
				reference.set_scale(Vector2(1, 1))
				reference.rotation = deg_to_rad(0)
			elif delta_pos > 0:
				reference.scale = Vector2(1, -1)
				reference.rotation = deg_to_rad(180)
			state_machine.transition_to("Fight", {"target" : reference.ally_detection_zone.allies[0]})
