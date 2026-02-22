class_name Transition extends CanvasLayer

static var latest : Transition = null

func _ready():
	latest = self
	$ColorRect.color.a = 1.0
	$AnimationPlayer.play_backwards("FadeToBlack")

func change(scenePath: String):
	$AnimationPlayer.play("FadeToBlack")
	
	await $AnimationPlayer.animation_finished
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	get_tree().change_scene_to_file(scenePath)
