class_name King
extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite
@onready var stats = $Stats


enum {
	MOVE,
	ATTACK,
	DEAD
}


var state = MOVE 

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			animation_player.play("Attack")
		DEAD:
			animation_player.play("Death")
	
func move_state(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_player.play("Run")
		if input_vector.x > 0:
			self.set_scale(Vector2(1, 1))
			self.rotation = deg_to_rad(0)
		elif input_vector.x < 0:
			self.scale = Vector2(1, -1)
			self.rotation = deg_to_rad(180)
	else:
		animation_player.play("Idle")
	
	velocity = input_vector * stats.speed
	
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_animation_finish():
	state = MOVE

func death_animation_finish():
	print("king ded")
	queue_free()

func _on_hurt_box_area_entered(area):
	stats.health -= area.damage
	print("king health: " + str(stats.health))
	pass


func _on_stats_die():
	state = DEAD
