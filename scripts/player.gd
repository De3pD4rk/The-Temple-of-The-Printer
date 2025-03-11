extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vine_ray_cast: RayCast2D = $VineRayCaster
@onready var spike_ray_cast: RayCast2D = $SpikeRayCaster

@export var inventory: Inventory

func _ready():
	inventory.use_item.connect(use_item)

func _physics_process(delta: float) -> void:
	# Check player colision with the spikes
	if spike_ray_cast.get_collider():
		print("You died!")
		self.inventory.clear()
		get_tree().reload_current_scene()
	
	# Override normal movement if player is on the vine
	if vine_ray_cast.get_collider():
		_climb_vine(delta)
	else:
		_movement(delta)
	
	move_and_slide()
	
func _climb_vine(delta):
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("interact", "crouch")
	
	if direction:
		velocity = direction * SPEED / 2
	else:
		velocity = Vector2.ZERO
	
func _movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x += get_gravity().x * delta 
		velocity.y += min(get_gravity().y * delta, 150)
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _on_hurt_box_area_entered(area):
	if area.has_method("collect") and not inventory.isFull():
		area.collect(inventory)

func use_item(item: InventoryItem) -> void:
	item.use(self)
