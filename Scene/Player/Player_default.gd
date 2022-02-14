extends KinematicBody2D


var velocity = Vector2.ZERO
var jump_force = 250
var gravity = 9.8


var player_can_act = false
var can_control_player = true
signal player_dead

func _ready():
	idle_state()
	
	

func idle_state():
	$AnimatedSprite.play("idle")


func _input(event):
	if player_can_act == true:
		if can_control_player == true:
			if Input.is_action_just_pressed("Left Mouse")or Input.is_action_just_pressed("Space"):
				velocity.y = -jump_force
				$AnimatedSprite.play("jump")



func _process(delta):
	if player_can_act == true:
		if velocity.y < 150:
			velocity.y += gravity
		if velocity.y > 1:
			$AnimatedSprite.play("fall")
		
		move_and_collide(velocity * delta)
	
	if is_on_floor():
		velocity.y = 0


func get_up():
	var vel = Vector2(1,-1)
	var force = 20
	self.position += vel * force
	player_can_act = true
	$AnimatedSprite.play("jump")
	pass



func die():
	$AnimatedSprite.play("die")
	$detector.set_deferred("monitoring",false)
	$CollisionShape2D.set_deferred("disabled",true)
	
	


func _on_detector_body_entered(body):
	if player_can_act == true:
		if body.is_in_group("obstacle"):
			die()
			can_control_player = false
			emit_signal("player_dead")


