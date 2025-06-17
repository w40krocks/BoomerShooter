extends Node
class_name SaveSystem

var SaveFile : WorldSaveResource
var SaveFileLocation

func CreateSaveFile(World : Node3D):
	SaveFile = WorldSaveResource.new()
	SceneChildrenSearchSAVE(World)
	SaveResource(World)

func SceneChildrenSearchSAVE(Parent : Node3D): ##searches through the entire scene and saves all data that needs to be save
	for i in Parent.get_child_count():
		if Parent.get_child(i) is PlayerCharacter:
			SaveFile.PlayerInfo = Parent.get_child(i).CharacterStat.duplicate()
			SaveFile.PlayerInfo.SpawnPos = Parent.get_child(i).global_position
			SaveFile.PlayerInfo.SpawnRotation = Parent.get_child(i).rotation
			
			
			
			SaveFile.PlayerINV = Parent.get_child(i).find_child("WeaponManager").Inventory.duplicate()
			
			
		elif Parent.get_child(i) is BaseEnemy:
			SaveFile.Enemies.append(Parent.get_child(i).CharacterStat)
			
		else:
			if Parent.get_child(i).get_child_count() != 0:
				SceneChildrenSearchSAVE(Parent.get_child(i))

func SaveResource(World):
	SaveFileLocation = "user://Save System/SaveDir/" 
	var SaveFilePath = SaveFileLocation + World.name + ".tres"
	DoesSaveFileExist(SaveFileLocation)
	ResourceSaver.save(SaveFile,SaveFilePath)

func DoesSaveFileExist(SaveFileLocation : String):
	if !DirAccess.dir_exists_absolute(SaveFileLocation):
		DirAccess.make_dir_absolute(SaveFileLocation)

	

func LoadSaveFile(World):
	var SaveFileLocation = "user://Save System/SaveDir/" + World.name + ".tres"
	DoesSaveFileExist("user://Save System/SaveDir/")
	
	var SaveFile = ResourceLoader.load(SaveFileLocation) as WorldSaveResource
	var Player : PlayerCharacter= World.find_child(SaveFile.PlayerInfo.CharacterName) 

	Player.CharacterStat = SaveFile.PlayerInfo.duplicate()
	Player.position = Player.CharacterStat.SpawnPos
	Player.rotation = Player.CharacterStat.SpawnRotation
	
	

	
	
	Player.find_child("WeaponManager").Inventory = SaveFile.PlayerINV.duplicate()
	Player.find_child("WeaponManager").InventoryCheck()
	for i in SaveFile.Enemies.size():
		print(SaveFile.Enemies[i].CharacterName)
		var tempEnemy = World.find_child(SaveFile.Enemies[i].CharacterName)
		print(tempEnemy)
		if tempEnemy is not BaseEnemy:
			print(tempEnemy," either doesnt exist at this point of the level, or is the incorrect type?")
		else:
			tempEnemy.CharacterStat = SaveFile.Enemies[i].duplicate()
			tempEnemy.global_position = tempEnemy.CharacterStat.SpawnPos
			tempEnemy.global_rotation = tempEnemy.CharacterStat.SpawnRotation
			tempEnemy = null
	
