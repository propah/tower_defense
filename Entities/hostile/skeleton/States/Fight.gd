extends SkeletonState

var target
var anim_finished: float
var rest_time: float
var did_hit: bool
@onready var timer: Timer = $Timer
signal target_killed(target)

func physics_update(_delta: float) -> void:
	rest_time = (1 - reference.get_node("AnimationPlayer").current_animation_length)/reference.stats.attack_speed
	
	if anim_finished:
		reference._play_animation("Idle", 1)
		if not did_hit:
			timer.stop()
			state_machine.transition_to("Move")
	else:
		reference._play_animation("Attack", reference.stats.attack_speed)
		if reference.get_node("SwordHitBox").get_overlapping_areas() != []:
			did_hit = true
	
	if not is_instance_valid(target):
		emit_signal("target_killed", target)
		state_machine.transition_to("Move")

func enter(msg := {}) -> void:
	target = msg["target"]
	anim_finished = false
	did_hit = false
	timer.wait_time = (1 - reference.get_node("AnimationPlayer").current_animation_length)/reference.stats.attack_speed
	timer.start()


func _on_animation_player_animation_finished(anim_name) -> void:
	if anim_name == "Attack":
		anim_finished = true
		timer.start()
	
func _on_timer_timeout() -> void:
	anim_finished = false
	did_hit = false
	timer.stop()

