extends Spatial

func _ready():
	get_node("/root/Global").update_score(0)

func _unhandled_input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
