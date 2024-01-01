extends Node


signal hit_enemy(id)
signal hit_object
signal hit_pole
signal game_over

var highest_score = 0
var pole_health = 100
var score = 0


func hit_enemy_func(id):
	score += 10
	
	hit_enemy.emit(id)
	
func hit_object_func():
	hit_object.emit()
	

func hit_pole_func(damage):
	pole_health -= damage
	if pole_health <= 0:
		if score > highest_score:
			highest_score = score
			
		game_over.emit()
	hit_pole.emit(damage)
