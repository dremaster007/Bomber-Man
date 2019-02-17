extends StaticBody2D

#Array of all of my raycast 2D's
onready var checks = {	"up": $UpCheck,
						"down": $DownCheck,
						"left": $LeftCheck,
						"right": $RightCheck}

#How far the bomb can explode to
var bomb_strength = 3

var parent

func _ready():
	#Disable the collision on start so the player doesn't get stuck in it.
	$CollisionShape2D.disabled = true
	#start the collision timer to enable it after 0.5 seconds
	$CollisionWaitTimer.start()

func _process(delta):
	raycast_update()

#update the raycasts to cast as far as the bomb's strength
func raycast_update():
	checks.up.cast_to = Vector2(0, bomb_strength * -64)
	checks.down.cast_to = Vector2(0, bomb_strength * 64)
	checks.left.cast_to = Vector2(bomb_strength * -64, 0)
	checks.right.cast_to = Vector2(bomb_strength * 64, 0)

func create_explosion():
	# if right raycast collides with something...
	if checks.right.is_colliding():
		# make hit_collider = to the thing getting hit
		var hit_collider = checks.right.get_collider()
		#if the collider's name is walls...
		if hit_collider.name == "Walls":
			#set var tilemap to the object
			var tilemap = hit_collider
			#set the hit position = 
			#var hit_pos = tilemap.position
			var hit_pos = position + Vector2(64, 0)
			var tile_pos = tilemap.world_to_map(hit_pos)
			for i in range(bomb_strength):
				var tile_id = tilemap.get_cellv(tile_pos)
				if tile_id == 2:
					tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
					break
				elif tile_id != 2:
					if tile_id != 3:
						tile_pos = Vector2(tile_pos.x + 1, tile_pos.y)
		if hit_collider.name == "Player1" or hit_collider.name == "Player2":
			hit_collider.queue_free()
	if checks.left.is_colliding():
		var hit_collider = checks.left.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(-64, 0)
			var tile_pos = tilemap.world_to_map(hit_pos)
			for i in range(bomb_strength):
				var tile_id = tilemap.get_cellv(tile_pos)
				if tile_id == 2:
					tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
					break
				elif tile_id != 2:
					if tile_id != 3:
						tile_pos = Vector2(tile_pos.x - 1, tile_pos.y)
		if hit_collider.name == "Player1" or hit_collider.name == "Player2":
			hit_collider.queue_free()
	if checks.up.is_colliding():
		var hit_collider = checks.up.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(0, -64)
			var tile_pos = tilemap.world_to_map(hit_pos)
			for i in range(bomb_strength):
				var tile_id = tilemap.get_cellv(tile_pos)
				if tile_id == 2:
					tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
					break
				elif tile_id != 2:
					if tile_id != 3:
						tile_pos = Vector2(tile_pos.x, tile_pos.y - 1)
		if hit_collider.name == "Player1" or hit_collider.name == "Player2":
			hit_collider.queue_free()
	if checks.down.is_colliding():
		var hit_collider = checks.down.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(0, 64)
			var tile_pos = tilemap.world_to_map(hit_pos)
			for i in range(bomb_strength):
				var tile_id = tilemap.get_cellv(tile_pos)
				if tile_id == 2:
					tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
					break
				elif tile_id != 2:
					if tile_id != 3:
						tile_pos = Vector2(tile_pos.x, tile_pos.y + 1)
		if hit_collider.name == "Player1" or hit_collider.name == "Player2":
			hit_collider.queue_free()
	
	#destroy
	queue_free()

func _on_CollisionWaitTimer_timeout():
	#enable the hitbox
	$CollisionShape2D.disabled = false

func _on_BombDetonateTimer_timeout():
	create_explosion()
	print("BOOM")
	parent.bomb_count += 1

