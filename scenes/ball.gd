extends RigidBody2D

var radius: float = 20.0
var bounce_speed: float = 900.0
var horizontal_strength: float = 260.0
var max_horizontal_speed: float = 420.0

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(1.0, 0.35, 0.35))
	draw_circle(Vector2.ZERO, radius, Color(0, 0, 0, 0.25))  # subtle rim

func _process(_delta: float) -> void:
	queue_redraw()

func bounce_off_platform(platform: Node) -> void:
	var offset: float = (global_position.x - platform.global_position.x) / platform.half_width
	offset = clamp(offset, -1.0, 1.0)


	var vy: float = -bounce_speed

	
	var vx: float = offset * horizontal_strength + platform.get_velocity_x() * 0.4
	vx = clamp(vx, -max_horizontal_speed, max_horizontal_speed)

	linear_velocity = Vector2(vx, vy)
	angular_velocity = offset * 6.0

func reset_ball(start_pos: Vector2) -> void:
	freeze = false
	linear_velocity = Vector2(randf_range(-180.0, 180.0), 0.0)
	angular_velocity = 0.0
	global_position = start_pos
