class_name EmailResource extends Resource

# information regarding the email
@export var id: StringName
@export var subject: String
@export var fromAddress: String
@export var toAddress: String
@export var attachment: Texture2D
@export_multiline var contents: String

@export var color: Color
@export var brightness: float

# state variables that the email manager can use


func _init():
	id = "test_email"
	subject = "doing some tests!"
	fromAddress = "John Tester"
	toAddress = "Jane Tester"
	contents = "Lorem ipsum blah blah blah\n\nSincerely\n\tJohn Tester"

	color = Color.GREEN
	brightness = 1.0
