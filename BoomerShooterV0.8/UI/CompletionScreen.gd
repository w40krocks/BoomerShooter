extends Control

@export var CurrentWorld : Node3D

@onready var MaxSecret : int = 0
@onready var FoundSecrets : int = 0
@onready var MaxEnemy : int = 0
@onready var EnemyDeaths : int = 0

var PlayerCompletionTime : float
var PlayerCompletionTimePRETTY : String
var DevCompletionTime : String 

@export var LABELmaxSecret : Label
@export var LABELfoundSecret : Label
@export var LABELMaxEnemy : Label
@export var LABELEnemyDeaths : Label

@export var LABELcompletionTime : Label
@export var LABELdevCompletionTime : Label

func Funky():
	FillInfo(CurrentWorld)
	CompletionTimeNormalisation()
	DevCompletionTime = CurrentWorld.get_meta("DevTime")
	UpdateLabels()

func UpdateLabels():
	LABELEnemyDeaths.text = str(EnemyDeaths)
	LABELfoundSecret.text = str(FoundSecrets)
	
	LABELMaxEnemy.text = str(MaxEnemy)
	LABELmaxSecret.text = str(MaxSecret)
	
	LABELcompletionTime.text = str(PlayerCompletionTimePRETTY)
	LABELdevCompletionTime.text = str(DevCompletionTime)

func FillInfo(Parent : Node):
	for i in Parent.get_child_count():
		if Parent.get_child(i) is BaseEnemy:
			MaxEnemy += 1
			if !Parent.get_child(i).CharacterStat.IsAlive:
				EnemyDeaths += 1
		elif Parent.get_child(i) is SecretArea:
			MaxSecret += 1
			if Parent.get_child(i).HasBeenVisited:
				FoundSecrets += 1
		elif Parent.get_child(i).get_child_count() > 0:
			FillInfo(Parent.get_child(i))

func CompletionTimeNormalisation():
	var temp = PlayerCompletionTime
	var MinuteCount = 0
	while temp > 60:
		MinuteCount +=1
		temp -= 60
	
	PlayerCompletionTimePRETTY = (str(MinuteCount)+ ":"+ str(temp).substr(0,2))
	

func UpdateCompletionTimer():
	PlayerCompletionTime += 0.1


func Button_ExitPressed():
	var sSystem = SaveSystem.new()
	sSystem.CreateSaveFile(get_tree().current_scene)
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func Button_RestartPressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1

func Button_UserFeedback():
	OS.shell_open("https://docs.google.com/forms/d/e/1FAIpQLScQgdKE5u6ukxPNBnBz9UXjCK0UODuC2sbhxhhMt5S8YNeG1A/viewform?usp=header")
