extends Node2D

export (int) var ob_gap = 128
var sight
var in_screen_once = false


func _ready():
	sight = [$Node2D2/Position2D.position.y,$Node2D2/Position2D2.position.y,$Node2D2/Position2D3.position.y,$Node2D2/Position2D4.position.y,$Node2D2/Position2D5.position.y]
	randomize()
	sight.shuffle()
	$obstacleHolder.position.y = sight[0]
	$obstacleHolder/obstacle1.position.x = -16
	$obstacleHolder/obstacle2.position.x = -16
	$obstacleHolder/obstacle1.position.y = 0
	$obstacleHolder/obstacle2.position.y = ob_gap


func _on_VisibilityNotifier2D_screen_entered():
	in_screen_once = true


func _on_VisibilityNotifier2D_screen_exited():
	if in_screen_once == true:
		queue_free()
		if get_parent().get_parent().get_parent().name == "Game":
			get_parent().get_parent().get_parent().count_obstacle()


func _on_PointAdder_body_entered(body):
	if body.is_in_group("player"):
		global.score += 1
