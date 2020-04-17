extends KinematicBody

var target

onready var player = get_node("../Player").global_transform.origin

		
		

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")
		set_color_red()
		look_at(player, Vector3.UP)

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		print(body.name + " exited")
		set_color_grey()

func set_color_red():
	$MeshInstance2.get_surface_material(0).set_albedo(Color(1, 0, 0))

func set_color_grey():
	$MeshInstance2.get_surface_material(0).set_albedo(Color("#bab7b7"))
