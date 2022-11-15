extends KingState

var delta_pos: float = 0
var target
var move_direction: Vector2 = Vector2.ZERO

func set_target_location(targett: Vector2) -> void:
	reference.navigation_agent.set_target_location(targett)

func arrived_at_location() -> bool:
	return reference.navigation_agent.is_navigation_finished()

func physics_update(_delta: float) -> void:
	if not is_instance_valid(target):
		state_machine.transition_to("Move")
		return
	var hitbox_obj: CollisionShape2D = reference.get_node("SwordHitBox").get_node("CollisionShape2d")
	var pin_point: float
	if reference.rotation == deg_to_rad(180):
		pin_point = hitbox_obj.position.x - hitbox_obj.shape.size.x/2
	else:
		pin_point = hitbox_obj.position.x + hitbox_obj.shape.size.x/2
	delta_pos =  reference.position.x - target.global_position.x
	if delta_pos >= 0:
		# TODO CHANGE HITBOX POS TO BE THE CENTER OF THE BOX
		set_target_location(target.global_position + Vector2(pin_point, 0))
	else:
		set_target_location(target.global_position - Vector2(pin_point, 0))
	
	move_direction = reference.position.direction_to(reference.navigation_agent.get_next_location())
	reference.velocity = move_direction * reference.stats.speed
	reference.navigation_agent.set_velocity(reference.velocity)

	if not arrived_at_location():
		reference.move_and_slide()
	else:
		if delta_pos < 0:
			reference.set_scale(Vector2(1, 1))
			reference.rotation = deg_to_rad(0)
		elif delta_pos > 0:
			reference.scale = Vector2(1, -1)
			reference.rotation = deg_to_rad(180)
		state_machine.transition_to("Fight", {"target" : target})

func enter(msg := {}) -> void:
	target = msg["target"]
