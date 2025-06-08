extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func gameover() -> void:
	#$ScoreTimer.stop()
	$Mobtimer.stop()
	$HUD.show_game_over()
	#$Music.stop()
	$Deathsound.play()
	get_tree().call_group("mobs", "queue_free")

func new_game():
	score = 0
	#$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Loading...please wait ")
	get_tree().call_group("mobs", "queue_free")
	#$Music.play()
	
	

func _on_mobtimer_timeout() -> void:
	$HUD.show_message("")
	#$HUD.hide_button()
	
	# Create a new instance of the Mob scene.


	# Choose a random location on Path2D.
	for spawns in range(1,number_of_spawns()):
		var mob = mob_scene.instantiate()
		$Spawn.play()
		var mob_spawn_location = $MobPath/MobSpawnLocation
		mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
		mob.position = mob_spawn_location.position*randf()

	# Set the mob's direction perpendicular to the path direction.
		var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
		direction += randf_range(-PI / 4, PI / 4)
		mob.rotation = direction

	# Choose the velocity for the mob.
		var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
		mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
		add_child(mob)
	pass # Replace with function body.


func _on_scoretimer_timeout() -> void:
	score=+1
	#$HUD.update_score(score)
	pass # Replace with function body.


func _on_starttimer_timeout() -> void:
	$Mobtimer.start()
	$ScoreTimer.start()
	#$HUD.update_score(score)


func _on_score_timer_timeout() -> void:
	pass # Replace with function body.

func number_of_spawns():
	var variables_of_weather=$HUD.get_variables();
	var amount_of_organism=0.5*variables_of_weather["water"]+0.03*variables_of_weather["humidity"]-0.05*(variables_of_weather["temperature"]-30)+0.5*variables_of_weather["cloud"]
	print(variables_of_weather)
	return int(amount_of_organism);
