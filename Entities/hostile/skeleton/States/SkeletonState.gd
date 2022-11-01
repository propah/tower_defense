class_name SkeletonState
extends State

var reference: Skeleton


func _ready() -> void:
	await owner.ready
	reference = owner as Skeleton
	assert(reference != null)
