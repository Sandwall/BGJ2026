extends Control

func _ready():
	$VBoxContainer/Play.connect("mouse_entered", post_hover_event)
	$VBoxContainer/Play.connect("pressed", post_pressed_event)
	$VBoxContainer/Quit.connect("mouse_entered", post_hover_event)
	$VBoxContainer/Quit.connect("pressed", post_pressed_event)
	Wwise.add_default_listener(self)

func post_pressed_event():
	Wwise.post_event("PLAY_SFX_UISelect", self)

func post_hover_event():
	Wwise.post_event("PLAY_SFX_UIHover", self)

func _on_play_pressed():
	$Transition.change("res://Scenes/Main.tscn")

func _on_quit_pressed():
	get_tree().quit()
