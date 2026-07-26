extends StaticBody2D

@export var speed: float = 550.0
var half_width: float = 75.0
var half_height: float = 10.0
var screen_width: float = 800.0
var current_velocity_x: float = 0.0

func _ready() -> void:
	add_to_group("platform")
	$Area2D.body_entered.connect(_on_bounce_zone_body_entered)


func _physics_process(delta: float) -> void:
	var dir := 0.0
	if Input.is_action_pressed("ui_left"):
		dir -= 1.0
	if Input.is_action_pressed("ui_right"):
		dir += 1.0

	current_velocity_x = dir * speed
	position.x += current_velocity_x * delta
	position.x = clamp(position.x, half_width, screen_width - half_width)
	queue_redraw()

func get_velocity_x() -> float:
	return current_velocity_x

func _on_bounce_zone_body_entered(body: Node) -> void:
	if body.has_method("bounce_off_platform"):
		body.bounce_off_platform(self)
