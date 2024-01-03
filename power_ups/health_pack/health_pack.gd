extends Area2D

func _on_body_entered(body):
	queue_free()
	if body.has_method("pick_up_power_up"):
		body.pick_up_power_up("health_pack") 
