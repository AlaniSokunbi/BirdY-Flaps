extends Node

var player_is_dead = false
var level_active = false

func _ready():
	set_background_texture()


func start_level():
	level_active = true
	$CanvasLayer/Score.show()
	kick_player()
	spawn_obstacles()


func kick_player():
	$Node2D/player.get_up()


func _process(delta):
	if level_active == true:
		$CanvasLayer/Score/ScoreTxt.text = str(global.score)
		if player_is_dead == false:
			$Node2D/Map.position.x -= 1


func spawn_obstacles():
	var min_obsct_count = 10
	for i in min_obsct_count:
		var obst_inst = ResourceLoader.load("res://Scene/Obstacle/Obstacle.tscn").instance()
		$Node2D/Map.add_child(obst_inst)
		obst_inst.position.x = $Node2D/Map/SpawnPoint.position.x
		$Node2D/Map/SpawnPoint.position.x = obst_inst.get_node("NextPoint").global_position.x


func count_obstacle():
	if $Node2D/Map.get_child_count() < 6:
		spawn_obstacles()

func set_background_texture():
	var rand_background
	randomize()
	rand_background = randi()%5
	$Background/TextureRect.texture = ResourceLoader.load("res://Assets/Sprite/Background/Background" +  str(rand_background) + ".png")
	pass


func game_over():
	player_is_dead = true
	set_score()
	$CanvasLayer/Control/GameOver.popup()
	$CanvasLayer/Score.hide()
	$CanvasLayer/Control/GameOver/VBoxContainer/BestScoreTxt.text = str(global.best_score)
	$CanvasLayer/Control/GameOver/VBoxContainer/ScoreTxt.text = str(global.score)

func set_score():
	if global.score > global.best_score:
		global.best_score = global.score
	global.save_score()
	

func _on_restart_pressed():
	get_tree().change_scene("res://Scene/Menu/Menu.tscn")


func _on_Play_pressed():
	start_level()
