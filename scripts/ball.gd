extends Sprite2D

var clickProcessed = false
@onready var controller = get_tree().get_root().get_node("world")
var currentColor

# Called when the node enters the scene tree for the first time.
func _ready():
	currentColor = controller.sendColor()
	modulate = currentColor
	
func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	#Hide children on click
	if(Input.is_action_just_pressed("click") && !clickProcessed):
		clickProcessed = true
		self.visible = false
		await get_tree().create_timer(.1).timeout
		controller.getColor(modulate)
		
func _process(_delta):
	pass
		
func _input(_event):
	if(Input.is_action_just_released("click")):
		clickProcessed = false
