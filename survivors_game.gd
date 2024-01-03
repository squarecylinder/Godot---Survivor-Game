extends Node2D

var score = 0

func _ready():
	%ScoreLabel.text = "Score: 0"

func spawn_mob():
	var new_slime = preload("res://mobs/slime/mob.tscn").instantiate()
	var new_fire_worm = preload("res://mobs/fire_worm/fire_worm.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_slime.give_score.connect(_on_mob_give_score)
	new_slime.global_position = %PathFollow2D.global_position
	new_fire_worm.give_score.connect(_on_mob_give_score)
	new_fire_worm.global_position = %PathFollow2D.global_position
	var enemies_array = [new_fire_worm, new_slime]
	add_child(enemies_array.pick_random())

func spawn_tree():
	var new_tree = preload("res://trees/pine_tree.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_tree.global_position = %PathFollow2D.global_position
	add_child(new_tree)

func _on_timer_timeout():
	spawn_mob()
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
	
func _on_mob_give_score(points):
	score += points
	%ScoreLabel.text = "Score: " + str(score)
