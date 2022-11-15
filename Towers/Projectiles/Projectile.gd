class_name Projectile
extends Node2D

@export var speed: float = 200.0
@export var pierce: int = 1
@onready var projectile_hit_box: Area2D = $ProjectileHitBox
@onready var projectile_hit_box_shape: CollisionShape2D = $ProjectileHitBox/CollisionShape2d
var damage
var is_init: bool = false
var on
var target
var target_last_pos: Vector2 = Vector2.ZERO
var move_direction: Vector2 = Vector2.ZERO


func _process(delta):
	if not is_init:
		print("error ", owner, " didn't init me ", self)
		return

	if projectile_hit_box.has_overlapping_areas():
		projectile_hit_box_shape.disabled = true
		queue_free()

	if is_instance_valid(target):
		target_last_pos = target.global_position
	else:
		if global_position.distance_squared_to(target_last_pos) < 10:
			queue_free()


	move_direction = global_position.direction_to(target_last_pos)
	
	if move_direction.x > 0:
		rotation = move_direction.y/1.2
	elif move_direction.x < 0:
		rotation = (-move_direction.y/1.2 + PI)

	global_position = global_position.move_toward(target_last_pos, delta * speed)
		

func init(target_, damage_: int):
	target = target_
	target_last_pos = target.global_position
	damage = damage_
	is_init = true
	

