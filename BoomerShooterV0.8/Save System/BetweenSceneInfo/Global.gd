extends Node

@onready var loadingSave : bool = false

@onready var Weapons : Dictionary = {
	"Pistol" : load("res://Item/UsedWeapons/RayWeapon/Pistol/pistol.tscn"),
	"Shotgun" : load ("res://Item/UsedWeapons/RayWeapon/Shotgun/shotgun.tscn")
}
