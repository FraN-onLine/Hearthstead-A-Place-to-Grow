extends CharacterBody2D

@export var speed := 80
var facing_right := true

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_vector * speed
	move_and_slide()

	var is_moving = input_vector != Vector2.ZERO
	var anim_name = "run" if is_moving else "idle"

	# Flip sprite based on movement direction
	if input_vector.x != 0:
		facing_right = input_vector.x > 0

	# Apply animation and flip to all AnimatedSprite2D children
	for sprite in get_children():
		if sprite is AnimatedSprite2D:
			sprite.animation = anim_name
			sprite.flip_h = not facing_right
			sprite.play()
