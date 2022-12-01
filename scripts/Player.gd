extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var movement = Vector2()
var speed = 1000
var state = "idle"
var sliding = false
var gravity = 0
var SlideTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	SlideTimer = Timer.new()
	SlideTimer.connect("timeout", self,"_on_SlideTimer_timeout")
	SlideTimer.wait_time = 2
	SlideTimer.one_shot = true
	add_child(SlideTimer)
	

func getinput():
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
			movement = Vector2()
			movement += Vector2.UP * 1000
			gravity = 0
			print("jmp")
	if Input.is_action_just_pressed("slide") && is_on_floor() && !sliding:
		sliding = true
		state = "slide"
		if Input.is_action_pressed("ui_left"):
			movement += Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			movement += Vector2.RIGHT
		if Input.is_action_pressed("ui_up"):
			movement += Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			movement += Vector2.DOWN
		SlideTimer.start()
	if(state == "idle"):
		movement = Vector2()
		if Input.is_action_pressed("ui_left"):
			movement += Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			movement += Vector2.RIGHT
		
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	getinput()
	gravity += 200 * delta
	move_and_collide(Vector2(0,gravity*delta))
	move_and_slide(movement * speed * delta)


func _on_SlideTimer_timeout():
	sliding = false
