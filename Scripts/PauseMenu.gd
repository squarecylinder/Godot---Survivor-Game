extends CanvasLayer

func _process(delta):
	visible = true if get_tree().paused else false
