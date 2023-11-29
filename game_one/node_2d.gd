extends Area2D
signal hit
@export var speed=400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size 
	hide()
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() >0:
		velocity = velocity.normalized() * speed
		$AnimaitedSprite2D.play()
	else:
		$AnimaitedSprite2D.stop()
	position += velocity * delta
	position = position.clamp (Vector2.ZERO, screen_size)
	if velocity.x !=0:
		$AnimaitedSprite2D.animation ="right"
		$AnimaitedSprite2D.flip_v = false
		#talk stuff (love you dad)
		$AnimaitedSprite2D.flip_h = velocity.x<0
	elif velocity.y!=0:
		$AnimaitedSprite2D.animation = "up"
		$AnimaitedSprite2D.flip_v = velocity.y > 0
		

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	emit_signal("hit")
