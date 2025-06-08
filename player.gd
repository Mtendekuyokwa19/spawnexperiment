extends Area2D
@export var speed=400
var screen_size
signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size=Vector2(1400,720)
	print(screen_size)
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity=Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y+=11
	if Input.is_action_pressed("move_up"):
		velocity.y-=11
	if Input.is_action_pressed("move_right"):
		velocity.x+=11
		position+=velocity*delta
	if Input.is_action_pressed("move_left"):
		velocity.x-=11
	if velocity.length()>0	:
		
		velocity=velocity.normalized()*speed
		$AnimatedSprite2D.play()
		
	else:
		$AnimatedSprite2D.stop()
	position+=velocity*delta
#	position=position.clamp(Vector2.ZERO,screen_size)
	if velocity.x !=0:
			$AnimatedSprite2D.animation="walk"
			$AnimatedSprite2D.flip_v=false
			$AnimatedSprite2D.flip_h=velocity.x<0
	elif velocity.y!=0 :
		$AnimatedSprite2D.animation="up"
		$AnimatedSprite2D.flip_v=velocity.y>0

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	#hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
