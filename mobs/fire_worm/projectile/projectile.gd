extends Area2D

var travelled_distance = 0

@onready var _anim_f_b = $AnimatedFireBall
@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	look_at(player.global_position)
	_anim_f_b.play("shoot")
	const SPEED = 500
	const RANGE = 500
	var direction = Vector2.RIGHT.rotated(rotation)
	
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	if body.has_method("player_hit"):
		_anim_f_b.play("explosion")
		body.player_hit(10.0)
		queue_free()
