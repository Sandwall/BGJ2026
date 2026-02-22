extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Wwise.register_game_obj(self, self.name);
	Wwise.load_bank("MainBank");
	Wwise.post_event("GLOBAL_StartGame", self);
