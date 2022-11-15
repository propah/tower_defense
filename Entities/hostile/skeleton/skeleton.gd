class_name Skeleton
extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var stats: EntityStats = $Stats
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2d
@onready var ally_detection_zone: AllyDetectionZone = $AllyDetectionZone
@onready var state_machine: StateMachine = $StateMachine
@export var goal: Vector2 = Vector2(-400, 700)

func _ready():
	navigation_agent.set_target_location(goal)

func _play_animation(animation_name: String, animation_speed = 1.0) -> void:
	animation_player.play(animation_name, -1 , animation_speed)

func death_animation_finish():
	# print("skeleton died")
	queue_free()

func create_blood_effect():
	var blood_effect_4 = load("res://Effects/blood/blood_effect_custom_2.tscn")
	var effect: Node2D = blood_effect_4.instantiate()
	add_child(effect)
	effect.global_position = global_position + Vector2(0, -4)

func _on_hurt_box_area_entered(area):
	stats.health -= area.damage
	# print("skeleton health: " + str(stats.health))
	create_blood_effect()
	
func _on_stats_die():
	# print("skeleton die signal")
	state_machine.transition_to("Die")
