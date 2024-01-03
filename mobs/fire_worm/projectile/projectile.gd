extends Area2D

var travelled_distance = 0

@onready var _anim_f_b = $AnimatedFireBall

func _physics_process(delta):
	#_anim_f_b.play("shoot")
	const SPEED = 1000
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("player_hit"):
		_anim_f_b.play("explosion")
		body.player_hit()
