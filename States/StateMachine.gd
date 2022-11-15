# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath("./Move")

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state = get_node(initial_state)

@onready var current_state_name: String = "Move"

func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


#func new_timestamp():
#	var tick = Time.get_ticks_msec()
#	var ms = str(tick)
#	ms.left(ms.length() - 1)
#	var timestamp = str(tick/3600000)+":"+str(tick/60000).pad_zeros(2)+":"+str(tick/1000).pad_zeros(2)+"."+ms+"\t"
#	return timestamp


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	current_state_name = target_state_name
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
