extends Node2D

var game_over: bool = false
var ball_start_pos: Vector2

func _ready() -> void:
	ball_start_pos = $RigidBody2D.global_position
	$Area2D.body_entered.connect(_on_floor_body_entered)
	$Timer.timeout.connect(_on_timer_timeout)
	$RigidBody2D.reset_ball(ball_start_pos)
	$Timer.start(60.0)

func _process(_delta: float) -> void:
	if not game_over:
		var t: int = int(ceil($Timer.time_left))
		$TimerLabel.text = "Time: %d" % t
	else:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene()

func _on_floor_body_entered(body: Node) -> void:
	if game_over:
		return
	if body == $RigidBody2D:
		_end_game(false)

func _on_timer_timeout() -> void:
	if not game_over:
		_end_game(true)

func _end_game(won: bool) -> void:
	game_over = true
	$RigidBody2D.linear_velocity = Vector2.ZERO
	$RigidBody2D.angular_velocity = 0.0
	$RigidBody2D.freeze = true
