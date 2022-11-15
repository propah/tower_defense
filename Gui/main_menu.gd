extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var start_button: Button = $VBoxContainer/StartButton
	start_button.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
