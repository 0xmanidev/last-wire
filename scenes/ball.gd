extends RigidBody2D

var radius: float = 20.0
var bounce_speed: float = 900.0
var min_bounce_speed: float = 700.0
var horizontal_strength: float = 260.0
var max_horizontal_speed: float = 420.0
var min_horizontal_kick: float = 60.0

@onready var bounce_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	var mat := PhysicsMaterial.new()
	mat.bounce = 1.0
	mat.friction = 0.0
	physics_material_override = mat

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(1.0, 0.35, 0.35))
	draw_circle(Vector2.ZERO, radius, Color(0, 0, 0, 0.25))

func _process(_delta: float) -> void:
	queue_redraw()

func bounce_off_platform(platform: Node) -> void:
	var offset: float = (global_position.x - platform.global_position.x) / platform.half_width
	offset = clamp(offset, -1.0, 1.0)

	var vy: float = -max(bounce_speed, min_bounce_speed)
	var vx: float = offset * horizontal_strength + platform.get_velocity_x() * 0.4

	if abs(vx) < min_horizontal_kick:
		var kick_dir: float = 1.0 if offset >= 0.0 else -1.0
		if offset == 0.0 and platform.get_velocity_x() == 0.0:
			kick_dir = 1.0 if randf() < 0.5 else -1.0
		vx = kick_dir * min_horizontal_kick

	vx = clamp(vx, -max_horizontal_speed, max_horizontal_speed)

	linear_velocity = Vector2(vx, vy)
	angular_velocity = offset * 6.0

	bounce_sfx.play()

func reset_ball(start_pos: Vector2) -> void:
	freeze = false
	linear_velocity = Vector2(randf_range(-180.0, 180.0), 0.0)
	angular_velocity = 0.0
	global_position = start_pos
