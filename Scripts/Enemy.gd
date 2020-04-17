extends KinematicBody

var space_state
var target
export var speed = 400

func _ready():
	space_state = get_world().direct_space_state

func _physics_process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			var player = get_node("../Player").global_transform.origin
			look_at(player, Vector3.UP)
			set_color_red()
			move_to_target(delta)
		else:
			set_color_grey()

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
		set_color_red()

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
		set_color_grey()

func move_to_target(delta):
	var dir = (target.transform.origin - transform.origin).normalized()
	move_and_slide(dir * speed * delta, Vector3.UP)

func set_color_red():
	$MeshInstance2.get_surface_material(0).set_albedo(Color(1, 0, 0))

func set_color_grey():
	$MeshInstance2.get_surface_material(0).set_albedo(Color("#bab7b7"))
