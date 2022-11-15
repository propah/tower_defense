extends Area2D

var pierced: int = 0
@onready var pierce: int = owner.pierce
@onready var damage: int = owner.damage:
	set(value):
		damage = value
	get:
		if pierced >= pierce:
			return -1
		return damage

func pierce_throught(pierced_throught: int):
	pierced += pierced_throught
