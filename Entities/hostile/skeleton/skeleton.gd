class_name Skeleton
extends CharacterBody2D

signal target_reached


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var stats: Stats = $Stats
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2d
@onready var ally_detection_zone: AllyDetectionZone = $AllyDetectionZone
@export var goal: Vector2 = Vector2(90, 455)
var move_direction: Vector2 = Vector2.ZERO
var did_arrive: bool = false

func _ready():
	set_target_location(goal)

func set_target_location(target: Vector2) -> void:
	did_arrive = false
	navigation_agent.set_target_location(target)
	

func _play_animation(animation_name: String, animation_speed = 1.0) -> void:
	animation_player.play(animation_name, -1 , animation_speed)

func _arrived_at_location() -> bool:
	return navigation_agent.is_navigation_finished()

func death_animation_finish():
	print("skeleton died")
	queue_free()

func create_blood_effect():
	var blood_effect_4 = load("res://Effects/blood/blood_effect_custom_2.tscn")
	var effect: Node2D = blood_effect_4.instantiate()
	add_child(effect)
	effect.global_position = global_position + Vector2(0, -4)

func _on_hurt_box_area_entered(area):
	stats.health -= area.damage
	print("skeleton health: " + str(stats.health))
	create_blood_effect()
	
func _on_stats_die():
	print("skeleton die signal")
