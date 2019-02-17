extends KinematicBody2D

export (PackedScene) var Bomb
export (int) var speed

var bomb_count = 3
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * speed)

func get_input():
	velocity = Vector2(0,0)
	var right = Input.is_action_pressed("p2_right")
	var left = Input.is_action_pressed("p2_left")
	var up = Input.is_action_pressed("p2_up")
	var down = Input.is_action_pressed("p2_down")
	var use_action = Input.is_action_just_pressed("p2_use_action")
	
	if right:
		velocity.x += speed
	if left:
		velocity.x -= speed
	if up:
		velocity.y -= speed
	if down:
		velocity.y += speed
	
	if velocity.length() > 1:
		velocity = velocity.normalized()
	
	if use_action:
		if bomb_count >= 1:
			bomb_count -= 1
			place_bomb(position)

func place_bomb(pos):
	var b = Bomb.instance()
	b.position = pos
	get_parent().add_child(b)
	b.parent = self