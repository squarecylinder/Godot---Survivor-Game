extends CharacterBody2D

signal give_score

var health = 5
var speed

@onready var _animated_sprite = $AnimatedSprite2D
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	speed = 300
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	if _animated_sprite.flip_h: #If we flipped it when it attacked, flip back or it will walk backwards LOL
		_animated_sprite.flip_h = false
	if global_position.distance_to(player.global_position) > 300: #idk, good distance to attack us from
		if health > 0: #If we are alive, keep on walking
			if direction[0] > 0:
				_animated_sprite.play("walk_right")
			if direction[0] < 0:
				_animated_sprite.play("walk_left")
			move_and_slide()
	else:
		speed = 0
		if direction[0] > 0: #If player is on the right normal attack anim
			_animated_sprite.play("attack")
		if direction[0] < 0: #If player is on the left, just flip the anim. Could flip spritesheet and redo but lazy
			_animated_sprite.flip_h = true
			_animated_sprite.play("attack")
	
func take_damage():
	if health > 0:
		_animated_sprite.play("hit")
		speed -= speed * .05
		health -= 1
	
	if health <= 0:
		_animated_sprite.play("death")

func _on_animated_sprite_2d_animation_finished():
	print(_animated_sprite.animation)
	if _animated_sprite.animation == "death":
		give_score.emit(3)
		queue_free()
