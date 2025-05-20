extends Control

@onready var world = $".."
# Called when the node enters the scene tree for the first time.
func _on_resume_pressed():
	#calls the pause menu function from the script attached to the World node
	world.pauseMenu()
	
func _on_quit_pressed():
	#shuts down the application
	get_tree().quit()
