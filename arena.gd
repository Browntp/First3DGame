extends Node3D

var enemy_scene = preload("res://enemy.tscn")

var enemies_on_pole = 0

func _ready():
	Singleton.connect("hit_enemy", enemy_killed)
	Singleton.connect("game_over", game_over)

func game_over():
	$DeathTimer.start()
	get_tree().call_group("enemy", "queue_free")
	print("game over functionc called")

func _on_enemy_spawn_timer_timeout():
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = get_random_spawn()
	var dir = $GoldenPoleArea.position - enemy_instance.position
	
	enemy_instance.direction = dir
	enemy_instance.id = enemy_instance.get_instance_id()
	add_child(enemy_instance)


func get_random_spawn():
	var marker_list = $EnemyMarkers.get_children()
	var random_number = randi_range(-1, len(marker_list)-1) 
	var random_location = marker_list[random_number].position
	return random_location


func _on_golden_pole_area_body_entered(body):
	if body.is_in_group("enemy"):
		Singleton.hit_pole_func(10)
		enemies_on_pole += 1
		
		
func enemy_killed(id):
	var enemy_instance = instance_from_id(id)
	enemy_instance.queue_free()


func _on_golden_pole_area_body_exited(body):
	if body.is_in_group("enemy"):
		var enemy_instance = instance_from_id(body.id)
		var dir = $GoldenPoleArea.position - enemy_instance.position
		enemy_instance.direction = dir
		enemies_on_pole -= 1
		

func _on_pole_damage_timer_timeout():
	if enemies_on_pole != 0:
		Singleton.hit_pole_func(enemies_on_pole* 10) 


func _on_death_timer_timeout():
	get_tree().change_scene_to_file("res://main_menu.tscn")
