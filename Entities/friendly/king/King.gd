class_name King
extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var stats: EntityStats = $Stats
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2d
@onready var enemy_detection_zone: EnemyDetectionZone = $EnemyDetectionZone
@onready var state_machine: StateMachine = $StateMachine
@export var defend_point: Vector2 = Vector2.ZERO

func _ready():
	defend_point = global_position
	navigation_agent.set_target_location(defend_point)

func _play_animation(animation_name: String, animation_speed = 1.0) -> void:
	animation_player.play(animation_name, -1 , animation_speed)

func death_animation_finish():
	queue_free()

func _on_hurt_box_area_entered(area):
	stats.health -= area.damage

func _on_stats_die():
	state_machine.transition_to("Die")
	
