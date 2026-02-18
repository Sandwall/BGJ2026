class_name EmailResource extends Resource

@export var id: StringName
@export var subject: String
@export var fromAddress: String
@export var toAddress: String
@export var contents: String
@export var color: Color
@export var brightness: float

func _init(pContent := "", pColor := Color.SKY_BLUE, pBrightness := 1.0):
	contents = pContent
	color = pColor
	brightness = pBrightness
