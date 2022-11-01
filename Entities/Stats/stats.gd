class_name Stats
extends Node

signal die

@export var max_health: int = 5
@export var wheight: int = 10
@export var damage: int = 2
@export var speed: int = 70
@export var attack_speed: float =  1
var health: int = max_health:
	set(value):
		health = value
		if health <= 0:
			emit_signal("die")
	get:
		return health
