extends Camera2D

var TOP_LEFT_POS := Vector2.ZERO

# Function called whenever the Camera2D, any node in this case, is initialized
func _ready():
	var playerPos = get_parent().get_node("Player").global_position #Player's position
	TOP_LEFT_POS.x = floor(playerPos.x / 576) * 576
	TOP_LEFT_POS.y = floor(playerPos.y / 320) * 320
	position_smoothing_enabled = false

# Function that aprox 60 times per second to check player position and the end of the screen
func _physics_process(delta):
	var playerPos = get_parent().get_node("Player").global_position
	
	if playerPos.x < TOP_LEFT_POS.x: # Left bound reached
		_update_screen(Vector2(TOP_LEFT_POS.x - 576, TOP_LEFT_POS.y))
	if playerPos.x > TOP_LEFT_POS.x + 576: # Right bound reached
		_update_screen(Vector2(TOP_LEFT_POS.x + 576, TOP_LEFT_POS.y))
	if playerPos.y < TOP_LEFT_POS.y: # Top bound reached
		_update_screen(Vector2(TOP_LEFT_POS.x, TOP_LEFT_POS.y - 320))
	if playerPos.y > TOP_LEFT_POS.y + 320:
		_update_screen(Vector2(TOP_LEFT_POS.x, TOP_LEFT_POS.y + 320))

# Function to apply changes to the camera position
func _update_screen(newPos):
	TOP_LEFT_POS = newPos
	global_position = newPos
	
