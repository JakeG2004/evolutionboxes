extends Node2D

var numballs = 0
const VARIANCE = -.1

var rng = RandomNumberGenerator.new()
var colors = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_node("balls").get_children():
		numballs += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func getColor(newColor):
	colors.insert(0, newColor)
	if(colors.size() >= numballs):
		showChildren()
		
func showChildren():
	print("Showing children")
	for i in get_node("balls").get_children():
		i.modulate = sendColor()
		i.visible = true
		
	colors = []

func sendColor():

	var r
	var g 
	var b
	
	var parent1
	var parent2

	#generate first color randomly
	if(colors.size() == 0):
		r = randf_range(0, 1)
		g = randf_range(0, 1)
		b = randf_range(0, 1)
		return(Color(r, g, b))
		
	#get 2 unique indeces from first half of list
	parent2 = pickWeightedParent()
	parent1 = pickWeightedParent()
	
	while(parent1 == parent2):
		parent2 = pickWeightedParent()
		
	#make new colors as result of old colors
	r = (parent1.r + parent2.r) / 2 + randf_range(-1 * VARIANCE, VARIANCE)
	g = (parent1.g + parent2.g) / 2 + randf_range(-1 * VARIANCE, VARIANCE)
	b = (parent1.b + parent2.b) / 2 + randf_range(-1 * VARIANCE, VARIANCE)
	
	return Color(r, g, b)
	
func pickWeightedParent():
	var totalWeight = 0
	for i in range(numballs):
		totalWeight += i
	
	var randNum = randi_range(0, totalWeight)
	var currentWeight = 0
	
	for i in range(numballs):
		currentWeight += i
		if(randNum <= currentWeight):
			return colors[i]
		
