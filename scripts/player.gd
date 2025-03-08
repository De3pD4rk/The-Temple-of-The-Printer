extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon_holder: Node2D = $WeaponHolder

@export var inventory: Inventory

var current_weapon: Node2D = null

func _ready():
	inventory.show_item.connect(show_item)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

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

	move_and_slide()
	

func _on_hurt_box_area_entered(area):
	if area.has_method("collect") and not inventory.isFull():
		area.collect(inventory)

	
func show_item(item: InventoryItem) -> void:
	if not current_weapon == null:
		weapon_holder.get_child(0).queue_free()
		current_weapon = null
	
	if item and item is ShotgunItem:
		current_weapon = item.new_instance()
		weapon_holder.add_child(current_weapon)
		
	if item and item is PrinterItem:
		current_weapon = item.new_instance()
		weapon_holder.add_child(current_weapon)
