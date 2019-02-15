extends StaticBody2D

var checks = {	"up": $UpCheck,
				"down": $DownCheck,
				"left": $LeftCheck,
				"right": $RightCheck}


func create_explosion():
	pass

func _on_BombDetonateTimer_timeout():
	create_explosion()
	print("BOOM")
	queue_free()
