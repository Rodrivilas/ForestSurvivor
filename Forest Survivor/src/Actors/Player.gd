extends Actor
class_name Player

var FLOOR_DETECT_DISTANCE = 40.0
var hurt = false
var dead = false
var health = 3
onready var platform_detector = $PlatformDetector
onready var shoot_timer = $ShootAnimation
onready var gun = $Sprite/Gun
onready var state_machine = $AnimationTree.get("parameters/playback")
onready var Damage = $Hurtbox/Damage
var sound_has_played = false
onready var DeathSound = $DeathSound


func _physics_process(_delta):
	if not dead:
		var direction = get_direction()

		var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
		var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
		var is_on_platform = platform_detector.is_colliding()
		_velocity = move_and_slide_with_snap(_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4,  0.9, false)


		if direction.x != 0:
			$Sprite.scale.x = direction.x

		var is_shooting = false
		
		if Input.is_action_just_pressed("shoot"):
			is_shooting = gun.shoot($Sprite.scale.x)

		
		if shoot_timer.is_stopped():
			if is_shooting:
				shoot_timer.start()
		state_machine.travel(_cambiar_animacion(is_shooting))
		if hurt:
			hurt=false
			health-=1
	else:
		_velocity=Vector2.ZERO
		state_machine.travel("death")
		if !sound_has_played:
			sound_has_played=true
			Damage.play()
			DeathSound.play()
		
func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity


func _cambiar_animacion(is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jumping"
	if is_shooting:
		animation_new += "_weapon"
	if hurt:
		print("uuughghgh")
		animation_new="hurt"
		Damage.play()
	
	return animation_new


func _on_Hurtbox_body_entered(body):
	hurt=true
	if health <= 1:
		dead=true
	
