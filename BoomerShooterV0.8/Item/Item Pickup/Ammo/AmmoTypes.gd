extends Resource
class_name AmmoResource


enum AmmoType {
	TEST, ##purely for test purposes
	BULLETS, ## Used by the Pistol and LMG
	SHELLS, ## Used by the shotgun
	BOMBS, ## Used by the Rocket Launcher
	}

@export var AmmoChoice : AmmoType
