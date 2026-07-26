extends Node



func _ready():
	DialogueManager.show_dialogue_balloon(
		load("res://scenes/intro.dialogue"),
        "start"
	)
