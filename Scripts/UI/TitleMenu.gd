extends Control

func _ready():
	$VBoxContainer/Button.connect("mouse_entered", post_hover_event)
	$VBoxContainer/Button.connect("pressed", post_pressed_event)
	$VBoxContainer/Button2.connect("mouse_entered", post_hover_event)
	$VBoxContainer/Button2.connect("pressed", post_pressed_event)
	$VBoxContainer/Button3.connect("mouse_entered", post_hover_event)
	$VBoxContainer/Button3.connect("pressed", post_pressed_event)

func post_pressed_event():
	Wwise.post_event("PLAY_SFX_UISelect", self)

func post_hover_event():
	Wwise.post_event("PLAY_SFX_UIHover", self)
