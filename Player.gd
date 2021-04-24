extends KinematicBody2D


var run_speed = 35
var jump_speed = -100
var gravity = 250

var velocity = Vector2()

var tilemap

func _ready():
	tilemap = get_node("/root/Scene/Ground/TileMap")

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed("ui_up")
	var dig = Input.is_action_just_pressed("dig")

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	if is_on_floor() and dig:
		dig()

func dig():

	var local_pos = tilemap.to_local(global_position)
	var tile_pos = tilemap.world_to_map(local_pos)

	if is_on_wall() and velocity.x > 0:
		excavate(Vector2(tile_pos.x+1, tile_pos.y))
		excavate(Vector2(tile_pos.x+1, tile_pos.y-1))
	elif is_on_wall() and velocity.x < 0:
		excavate(Vector2(tile_pos.x-1, tile_pos.y))
		excavate(Vector2(tile_pos.x-1, tile_pos.y-1))
	elif is_on_floor():
		var tile_underneath = Vector2(tile_pos.x, tile_pos.y+1)
		excavate(tile_underneath)
		
func excavate(tile):
		print("Excavating ", tile)
		tilemap.set_cell(tile.x, tile.y, -1)
		tilemap.update_dirty_quadrants()
	

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))

	
