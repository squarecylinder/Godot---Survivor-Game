extends CharacterBody2D

signal health_depleted
signal picked_up_power_up(power)

var health = 100.0
var speed = 600
@onready var damage_rate = 5
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if Input.is_action_pressed("move_left"):
		_animated_sprite.play("walk_left")
	elif Input.is_action_pressed("move_up"):
		_animated_sprite.play("walk_up")
	elif Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk_right")
	elif Input.is_action_pressed("move_down"):
		_animated_sprite.play("walk_down")
	else:
		_animated_sprite.play("idle")
		
	var overlapping_mobs = %HitBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= damage_rate * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()

func player_hit(value: float):
	health -= value
	%ProgressBar.value = health
	if health <= 0.0:
		health_depleted.emit()

func touching_enemy(value):
	damage_rate = value

func pick_up_power_up(power_up):
	if power_up == "faster_shots":
		picked_up_power_up.emit("faster_shots")
	if power_up == "health_pack":
		picked_up_power_up.emit("health_pack")
	if power_up == "speed_boost":
		picked_up_power_up.emit("speed_boost")

func _on_picked_up_power_up(power):
	if power == "health_pack":
		health += 25
		%ProgressBar.value = health
	if power == "speed_boost":
		speed += speed * .05
