extends Area2D

func _on_body_entered(body):
	if body.has_method("pick_up_power_up"):
		body.pick_up_power_up("speed_boost") 
		queue_free()
