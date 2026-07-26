extends Node2D

var game_over: bool = false
var game_started: bool = false
var ball_start_pos: Vector2

func _ready() -> void:
	ball_start_pos = $RigidBody2D.global_position
	$Area2D.body_entered.connect(_on_floor_body_entered)
	$Timer.timeout.connect(_on_timer_timeout)

	# Hold the ball still until the player is ready.
	$RigidBody2D.global_position = ball_start_pos
	$RigidBody2D.freeze = true
	$RigidBody2D.linear_velocity = Vector2.ZERO
	$RigidBody2D.angular_velocity = 0.0


func _process(_delta: float) -> void:
	if not game_started:
		return
	if not game_over:
		var t: int = int(ceil($Timer.time_left))
		$TimerLabel.text = "Time: %d" % t

func _unhandled_input(event: InputEvent) -> void:
	if game_started or game_over:
		return
	if event is InputEventKey and event.pressed or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") or event.is_action_pressed("ui_accept"):
		_start_game()

func _start_game() -> void:
	game_started = true
	$RigidBody2D.reset_ball(ball_start_pos)
	$Timer.start(60.0)
	$AnimatedSprite2D.visible = not $AnimatedSprite2D.visible
	$AnimatedSprite2D2.visible = not $AnimatedSprite2D2.visible

func _on_floor_body_entered(body: Node) -> void:
	if not game_started or game_over:
		return
	if body == $RigidBody2D:
		_end_game(false)

func _on_timer_timeout() -> void:
	if not game_over:
		_end_game(true)

func _end_game(won: bool) -> void:
	game_over = true
	$RigidBody2D.linear_velocity = Vector2.ZERO
	$TimerLabel.text = "Time: 0"
	$RigidBody2D.angular_velocity = 0.0
	$RigidBody2D.visible = not $RigidBody2D.visible
	await get_tree().create_timer(0.15).timeout
	$RigidBody2D.freeze = true
	GameState.won = won
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
