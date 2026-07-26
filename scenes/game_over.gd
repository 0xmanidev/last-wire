extends Node2D


func _ready() -> void:
	if GameState.won:
		$ResultLabel.text = "YOU WIN\nThe world is saved. The wire is intact."
		$Sprite0023.visible = false  # Win sprite
		$Sprite0003.visible = true   # Lose sprite
	else:
		$ResultLabel.text = "GAME OVER\nThe world ended. The wire was destroyed."
		$Sprite0023.visible = true   # Win sprite
		$Sprite0003.visible = false  # Lose sprite



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
