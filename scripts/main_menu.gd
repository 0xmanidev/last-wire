extends Control

@onready var click_sfx: AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	click_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://addons/dialogue_manager/test_scene.tscn")
	



	


func _on_about_pressed() -> void:
	click_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().change_scene_to_file("res://scenes/about.tscn")
	


func _on_exit_pressed() -> void:
	click_sfx.play()
	await get_tree().create_timer(0.15).timeout
	get_tree().quit()
	
