extends StaticBody2D

var explosion_size = 1

var checks = {	"up": $UpCheck,
				"down": $DownCheck,
				"left": $LeftCheck,
				"right": $RightCheck}


func create_explosion(e_size):
	explosion_size = e_size

func _on_BombDetonateTimer_timeout():
	create_explosion()
	print("BOOM")
	queue_free()
