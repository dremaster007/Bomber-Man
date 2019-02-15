extends StaticBody2D

onready var checks = {	"up": $UpCheck,
						"down": $DownCheck,
						"left": $LeftCheck,
						"right": $RightCheck}

var bomb_strength = 1

func _ready():
	$CollisionShape2D.disabled = true
	$CollisionWaitTimer.start()

func create_explosion():
	if checks.right.is_colliding():
		var hit_collider = checks.right.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(50, 0)
			var tile_pos = tilemap.world_to_map(hit_pos)
			var tile_id = tilemap.get_cellv(tile_pos)
			if tile_id == 2:
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
	
	if checks.left.is_colliding():
		var hit_collider = checks.left.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(-50, 0)
			var tile_pos = tilemap.world_to_map(hit_pos)
			var tile_id = tilemap.get_cellv(tile_pos)
			if tile_id == 2:
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)

	if checks.up.is_colliding():
		var hit_collider = checks.up.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(0, -50)
			var tile_pos = tilemap.world_to_map(hit_pos)
			var tile_id = tilemap.get_cellv(tile_pos)
			if tile_id == 2:
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)

	if checks.down.is_colliding():
		var hit_collider = checks.down.get_collider()
		if hit_collider.name == "Walls":
			var tilemap = hit_collider
			var hit_pos = position + Vector2(0, 50)
			var tile_pos = tilemap.world_to_map(hit_pos)
			var tile_id = tilemap.get_cellv(tile_pos)
			if tile_id == 2:
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
	queue_free()

func _on_CollisionWaitTimer_timeout():
	$CollisionShape2D.disabled = false

func _on_BombDetonateTimer_timeout():
	create_explosion()
	print("BOOM")

