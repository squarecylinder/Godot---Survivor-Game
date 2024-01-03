extends Area2D

func _physics_process(_delta):
	look_at(get_global_mouse_position()) #This points the gun to the cursor

func shoot():
	const BULLET = preload("res://pistol/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)

func _on_timer_timeout():
	shoot()

func _on_player_picked_up_power_up(_power):
	var timer_wait_time = $ShootingTimer.get_wait_time()
	$ShootingTimer.wait_time -= timer_wait_time * .05
