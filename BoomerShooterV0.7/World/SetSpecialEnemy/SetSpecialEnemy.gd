extends Node
class_name SetSpecialEnemy


func SetSpecialEnemy(EnemyToChange : BaseEnemy, OutlineColour : Color):
	SetGlowingOutline(OutlineColour,EnemyToChange.find_child("Sprite"))

func SetGlowingOutline(OutlineColour : Color,Sprite : Sprite3D  ):
	var tempOverride:= ShaderMaterial.new() 
	tempOverride.shader = load("res://Character/Enemy/Zombie/zombie.gdshader")
	
	Sprite.material_override = tempOverride
	tempOverride.set_shader_parameter("sprite_texture", load(Sprite.get_parent().SpriteSheet))
	tempOverride.set_shader_parameter("line_color",OutlineColour)
	tempOverride.set_shader_parameter("glowSize", 1)
