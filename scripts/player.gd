extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vine_ray_cast: RayCast2D = $VineRayCaster
@onready var spike_ray_cast: RayCast2D = $SpikeRayCaster
@onready var weapon_holder: Node2D = $WeaponHolder
@onready var coin_label: Label = $"../Camera2D/CoinCount"
@onready var death_label: Label = $"../Camera2D/DeathCount"
@onready var invulnerability_label: Label = $"../Camera2D/InvulnerabilityLabel"
@onready var playtime_label: Label = $"../Camera2D/PlaytimeLabel"

var is_invulnerable = false
@onready var invulnerability: Timer = $Invulnerability


@export var inventory: Inventory

var current_weapon : Node2D = null
var current_item_gui : InventoryItem = null

var coin_counter: int = 0

func _ready():
	inventory.show_item.connect(show_item)
		
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.coin_collected.connect(add_coin)
	
	get_tree().node_added.connect(_on_node_added)
	

func _process(delta):
	death_label.text = "Deaths: " + str(Global.death_counter)
	
	if is_invulnerable:
		invulnerability_label.text = str(ceil(invulnerability.time_left))
	
	var minutes = int(Global.playtime) / 60
	var seconds = int(Global.playtime) % 60
	playtime_label.text = "Time Played: %02d:%02d" % [minutes, seconds]
	
func _physics_process(delta: float) -> void:
	# Check player colision with the spikes
	if spike_ray_cast.get_collider() and spike_ray_cast:
		Global.death_counter += 1
		Global.kills = 0
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

func show_item(item: InventoryItem) -> void:
	if not current_weapon == null:
		weapon_holder.get_child(0).queue_free()
		current_weapon = null
		current_item_gui = null
	
	if item and item is ShotgunItem:
		current_weapon = item.new_instance()
		current_item_gui = item
		weapon_holder.add_child(current_weapon)
		
	if item and item is PrinterItem:
		current_weapon = item.new_instance()
		current_item_gui = item
		weapon_holder.add_child(current_weapon)
		
	if item and item is RedBlueItem:
		current_weapon = item.new_instance()
		current_item_gui = item
		weapon_holder.add_child(current_weapon)

func _on_node_added(node):
	if node.is_in_group("coins"):
		node.coin_collected.connect(add_coin)

func add_coin():
	coin_counter += 1
	coin_label.text = "Coin Count: " + str(coin_counter)
	Global.coins = coin_counter
	
func remove_item_from_inventory():
	inventory.remove(current_item_gui)
	current_weapon.queue_free()
	current_weapon = null

func activate_invulnerability(duration: float):
	is_invulnerable = true
	invulnerability.start(duration)
	invulnerability_label.text = str(duration)
	invulnerability_label.show()

func _on_invulnerability_timeout() -> void:
	is_invulnerable = false
	invulnerability_label.hide()
