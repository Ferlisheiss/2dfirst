extends KinematicBody2D

var velocity = Vector2()
const speed = 300
const gravity = 10
const jump = 400
const Floor = Vector2(0, -1)

enum States {
	IN_AIR, # В воздухе
	ON_FLOOR, # На полу 
	ON_WALL # На стене
} 




func _physics_process(_delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x =- speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =+ speed
	else:
		velocity.x = 0
		

		
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = - jump
		
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Floor)
	
	animate()
	
	
func animate():
	var anim = "idle"
	
	if velocity.x != 0:
		anim = "run"
		if velocity.x > 0:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
			
			
	#if он умирает("смерть"):
	#	anim = "смерть"
		
	#if Input.is_action_pressed("attack"):
	#	anim = "attack"
		
	#if его аттакуют("hurt"):
	#	anim = "hurt"	
		
			
	if velocity.y < 0 and not $RayCast2D.is_colliding():
		anim = "jump"
	elif velocity.y > 0 and not $RayCast2D.is_colliding():
		anim = "fall"
	
	#if Input.is_action_pressed("picking"):
	#	anim = "picking"
		
	#if Input.is_action_pressed("ui_down"):
	#	anim = "down"
	
			
	
	if $Sprite.animation != anim:
		$Sprite.play(anim) 
		


func _on_TileMap_script_changed():
	pass # Replace with function body.


func _on_Sprite_texture_changed():
	pass # Replace with function body.
