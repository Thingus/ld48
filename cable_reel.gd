extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var rope_path
var rope_segs = []
var rope_len = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Scene/Player")
	rope_path = preload("res://RopeSegment.tscn")
	add_rope_segment()

func add_rope_segment():
	var new_rope_seg = RigidBody2D.new()
	var new_rope_seg_collider = CollisionShape2D.new()
	var rope_seg_geom = SegmentShape2D.new()
	var reel_end_pin = PinJoint2D.new()
	var player_end_pin = PinJoint2D.new()
	
	
	rope_seg_geom.set_a(global_position)
	rope_seg_geom.set_b(player.position)
	new_rope_seg_collider.set_shape(rope_seg_geom)
	
	reel_end_pin.set_position(global_position)
	reel_end_pin.set_node_a(self.get_path())
	reel_end_pin.set_node_b(new_rope_seg.get_path())
	new_rope_seg.add_child(new_rope_seg_collider)
	new_rope_seg.add_child(reel_end_pin)
	player_end_pin.set_position(player.position)
	player_end_pin.set_node_a(new_rope_seg.get_path())
	player_end_pin.set_node_b(player.get_path())
	
	rope_segs.append(new_rope_seg)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
