extends Resource
class_name WeaponINV

var CurrentWeapon : BaseWeapon
var CurrentWeaponName : String
var Weapons : Dictionary = {}


@export var HeldAmmo : Dictionary = { ## holds the current and maximum amount of ammo held by the player
	"0-CurrentAmmo" : 0, # test
	"0-MaxAmmo" : 0,
	
	"1-CurrentAmmo" : 0, # bullet
	"1-MaxAmmo" : 0,
	
	"2-CurrentAmmo" : 0, # shell
	"2-MaxAmmo" : 0,
	
	"3-CurrentAmmo" : 0, # bomb
	"3-MaxAmmo" : 0
}
