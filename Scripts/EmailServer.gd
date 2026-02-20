class_name EmailServer extends MeshInstance3D
# so right now the email servers extend a mesh instance, but idk if we're going to have it like this regularly

@onready var meshInst: MeshInstance3D = self

func interact():
	Main.inst.hud.display_test_email()
