class_name FireTower
extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemy_detection_zone: EnemyDetectionZone = $EnemyDetectionZone
@onready var stats: TowerStats = $Stats
@onready var fire_cooldown_timer: Timer = $FireCooldown
@onready var projectile_spawn_location: Marker2D = $ProjectileSpawnLocation
@onready var projectile = preload("res://Towers/Projectiles/FireBall/fire_ball.tscn")
var on_cooldown: bool = false

func _ready():
	animation_player.play("Idle")
	fire_cooldown_timer.wait_time = 1/stats.attack_speed
	fire_cooldown_timer.start()


func _physics_process(_delta):
	if on_cooldown:
		return
	if enemy_detection_zone.in_range():
		fire_cooldown_timer.start()
		fire(enemy_detection_zone.enemies[0])
		on_cooldown = true

func fire(target):
	var instance = projectile.instantiate()
	instance.init(target, stats.damage)
	add_child(instance)
	instance.global_position = projectile_spawn_location.global_position


func _on_fire_cooldown_timeout():
	on_cooldown = false
	fire_cooldown_timer.stop()
