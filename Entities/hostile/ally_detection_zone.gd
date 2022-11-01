class_name AllyDetectionZone
extends Area2D

var allies = []
	
func allies_in_range():
	return allies

func in_range() -> bool:
	return len(allies) > 0

func _on_ally_detection_zone_body_entered(body):
	allies.append(body)

func _on_ally_detection_zone_body_exited(body):
	allies.erase(body)
