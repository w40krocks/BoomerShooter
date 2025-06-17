extends Control

@onready var FirstWorld :PackedScene = preload("res://Worlds/TestWorld/TestWorld.tscn")


func NewGame():
	get_tree().change_scene_to_packed(FirstWorld)

func ContinueGame():
	Global.loadingSave = true
	get_tree().change_scene_to_packed(FirstWorld)
	

func Quit():
	get_tree().quit()
