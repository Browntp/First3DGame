extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.connect("hit_enemy", hit_enemy_hitmarker)
	Singleton.connect("hit_pole", hit_pole)
	


func hit_enemy_hitmarker(id):
	
	$EnemyHitMarker.visible = true
	$HitmarkerVisibilityTimer.start()
	$ScoreLabel.text = "score: " + str(Singleton.score)

func _on_hitmarker_visibility_timer_timeout():
	$EnemyHitMarker.visible = false

func hit_pole(damage):
	$PoleHealthbar.value -= damage
