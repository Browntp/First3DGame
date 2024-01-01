extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HighestScore.text = "Highest Score: " + str(Singleton.highest_score)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	Singleton.score = 0
	Singleton.pole_health = 100
	get_tree().change_scene_to_file("res://arena.tscn")
