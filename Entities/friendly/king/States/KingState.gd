class_name KingState
extends State

var reference: King


func _ready() -> void:
	await owner.ready
	reference = owner as King
	assert(reference != null)
