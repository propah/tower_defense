class_name EnemyDetectionZone
extends Area2D

var enemies = []
	
func enemies_in_range():
	return enemies

func in_range() -> bool:
	return len(enemies) > 0

func _on_enemy_detection_zone_body_entered(body):
	enemies.append(body)


func _on_enemy_detection_zone_body_exited(body):
	enemies.erase(body)