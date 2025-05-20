extends Container

var InventorySlots : int
var counter : int

@onready var ContainerSprite = load("res://Character/Player/Container.png")

@onready var Style = load("res://Character/Player/Inventory.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	InventorySlots = 4
	counter = counter + (16 * InventorySlots)
	_SetInventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _SetInventory():
	
	for i in InventorySlots:
		
		var PanelCont = PanelContainer.new()
		PanelCont.custom_minimum_size = Vector2(16,16)
		PanelCont.add_theme_stylebox_override("h", Style)
		var Sprite = Sprite2D.new() 
		Sprite.centered = false
		Sprite.texture = ContainerSprite
		self.get_child(0).add_child(PanelCont)
		self.get_child(0).get_child(i).add_child(Sprite)
	self.size = Vector2(counter, 16)
	self.get_child(0).size = Vector2(counter, 16)
	print(self.size)
	self.scale = Vector2(2,2)
	
