extends KingState

func enter(_msg := {}) -> void:
	reference._play_animation("Idle")
	reference.set_scale(Vector2(1, 1))
	reference.rotation = deg_to_rad(0)


func _on_enemy_detection_zone_body_entered(body):
	if state_machine.current_state_name == "Idle":
		if body.state_machine.current_state_name == "Move":
			body.state_machine.state.set_chasing_target_and_transition(owner)
			state_machine.transition_to("Chase", {"target": body})
