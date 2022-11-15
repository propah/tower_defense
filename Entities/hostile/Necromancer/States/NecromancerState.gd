class_name NecromancerState
extends State

var reference: Necromancer


func _ready() -> void:
	await owner.ready
	reference = owner as Necromancer
	assert(reference != null)
