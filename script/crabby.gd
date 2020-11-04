extends KinematicBody2D


const SPEED = 100
const FLOOR = Vector2(0, -1)
const GRAVITY = 1000

var velocity = Vector2()
var direction = 1

func _physics_process(delta):
	velocity.x = SPEED * direction
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)
	
	animate()
	
	if is_on_wall():
		change_direction()
	
func change_direction():
	direction *= -1
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h

func animate():
	var anim = 'idle'
	

	if velocity.x != 0:
		anim = "run"
		if velocity.x > 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
			
			
	if velocity.y < 0 and not $RayCast2D.is_colliding():
		anim = "jump"
	elif velocity.y > 0 and not $RayCast2D.is_colliding():
		anim = "fall"
	
	
	
	
	
	
	
	if $AnimatedSprite.animation != anim:
		$AnimatedSprite.play(anim) 
