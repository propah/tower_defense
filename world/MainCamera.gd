extends Camera2D

@export var max_speed = 200
@export var speed = max_speed
@export var zoom_factor = 1 

func _ready():
	smoothing_enabled = true
	smoothing_speed = 6
	zoom_factor = 0.5

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	position += input_vector * speed * delta
	if Input.is_action_just_released("zoom_in"):
		zoom_factor *= 1.1
	if Input.is_action_just_released("zoom_out"):
		zoom_factor *= 0.9
		if zoom_factor <= 0.2:
			zoom_factor = 0.2
	speed = max_speed/float(zoom_factor)
	set_zoom(Vector2(1,1) * zoom_factor)
