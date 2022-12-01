extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var block

# Called when the node enters the scene tree for the first time.
func _ready():
	block = load("res://Scenes/block.tscn")
	for i in 30:
		for x in 10:
			var instance = block.instance()
			add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
