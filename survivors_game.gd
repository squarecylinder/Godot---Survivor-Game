extends Node2D

var score = 0

func _ready():
	%ScoreLabel.text = "Score: 0"

func spawn_mob():
	var new_mob = preload("res://mobs/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.give_score.connect(_on_mob_give_score)
	add_child(new_mob)

func spawn_tree():
	var new_tree = preload("res://trees/pine_tree.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_tree.global_position = %PathFollow2D.global_position
	add_child(new_tree)

func _on_timer_timeout():
	pass
	#spawn_mob()
	#spawn_tree()
	#spawn_tree()
	#spawn_tree()
	#spawn_tree()

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func spawn_power_up():
	var faster_shots = preload("res://power_ups/faster_shots/faster_shots.tscn").instantiate()
	var health_pack = preload("res://power_ups/health_pack/health_pack.tscn").instantiate()
	var speed_boost = preload("res://power_ups/speed_boost/speed_boost.tscn").instantiate()
	%PowerUpSpawn.progress_ratio = randf()
	faster_shots.global_position = %PowerUpSpawn.global_position
	health_pack.global_position = %PowerUpSpawn.global_position
	speed_boost.global_position = %PowerUpSpawn.global_position
	var power_up_array = [faster_shots, health_pack, speed_boost]
	add_child(power_up_array.pick_random())

func _on_power_up_timer_timeout():
	spawn_power_up()
	
func _on_mob_give_score():
	score += 1
	%ScoreLabel.text = "Score: " + str(score)
