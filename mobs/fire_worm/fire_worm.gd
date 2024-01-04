extends CharacterBody2D

signal give_score

var health = 5
var can_move = true
var speed = 300
var lock_animation = false

@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = get_node("/root/Game/Player")

func _physics_process(_delta):
	if health <= 0:
		_animated_sprite.play("death")
	if !lock_animation:
		speed = 300 if can_move else 0
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		if global_position.distance_to(player.global_position) > 300: #idk, good distance to attack us from
			if health > 0: #If we are alive, keep on walking
				if can_move: #Make shift way of making it so we don't cancel the attack if the player moves out of range
					if _animated_sprite.flip_h: #If we flipped it when it attacked, flip back or it will walk backwards LOL
						_animated_sprite.flip_h = false
					if direction[0] > 0:
						_animated_sprite.play("walk_right")
					if direction[0] < 0:
						_animated_sprite.play("walk_left")
					move_and_slide()
		else:
			if direction[0] > 0: #If player is on the right normal attack anim
				_animated_sprite.play("attack")
			if direction[0] < 0: #If player is on the left, just flip the anim. Could flip spritesheet and redo but lazy
				_animated_sprite.flip_h = true
				_animated_sprite.play("attack")
	
func take_damage():
	health -= 1
	if health > 0:
		_animated_sprite.play("hit")
		speed -= speed * .5 #should cause like a one frame stun idk
	
	if health <= 0:
		_animated_sprite.play("death")

func _on_animated_sprite_2d_animation_finished():
	if _animated_sprite.animation == "attack":
		shoot()
		can_move = true #Only move AFTER the worm has finished his attack animation
	if health <= 0:
		_animated_sprite.play("death")
	if _animated_sprite.animation == "death":
		give_score.emit(3)
		queue_free()
		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position

func shoot():
	var new_fire_ball = preload("res://mobs/fire_worm/projectile/projectile.tscn").instantiate()
	new_fire_ball.global_position = %ShootingPoint.global_position
	new_fire_ball.global_rotation_degrees = 0 if not _animated_sprite.flip_h else 180
	add_child(new_fire_ball)

func _on_animated_sprite_2d_animation_changed():
	if _animated_sprite.animation == "death":
		lock_animation = true
	if _animated_sprite.animation == "attack":
		can_move = false #As soon as we start the attack, worm should not be able to move anymore until its completed.
	
