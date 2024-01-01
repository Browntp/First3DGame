extends Camera3D

var ray_range = 2000

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("shoot"):
		get_camera_collision()


func get_camera_collision():
	var centre = get_viewport().get_size()/2
	var ray_origin = project_ray_origin(centre)
	var ray_end = ray_origin + project_ray_normal(centre) * ray_range
	var new_intersection = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = get_world_3d().direct_space_state.intersect_ray(new_intersection)
	
	if not intersection.is_empty() and can_shoot == true:
		var collider = intersection.collider
		$AudioStreamPlayer.playing = true
		can_shoot = false
		$ReloadTimer.start()
		if collider.is_in_group("enemy"):
			Singleton.hit_enemy_func(collider.id)
	else:
		print("nothing")


func _on_reload_timer_timeout():
	can_shoot = true
