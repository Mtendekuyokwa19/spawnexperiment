extends CanvasLayer
var tooglebutton="play"
signal  start_game
signal stop_game
func show_game_over():
	show_message("")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "The spawn experiment"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.text="Start"
	$StartButton.show()
	$Water.show()
	$Humidity.show()
	$Cloud.show()
	$Temperature.show()

func update_score(score):
	score=score+1
#	$ScoreLabel.text = str(score)
	
	#func _on_start_button_pressed():
	#$StartButton.hide()
#	if tooglebutton=="play":
#		$StartButton.text="stop"
#		tooglebutton="stop"	
#		start_game.emit()
#		print("start")
#	
#	elif tooglebutton=="stop":
#		$StartButton.text="Start"
#		tooglebutton="play"
#		stop_game.emit()
#		print("stop")
		
#	print($Water.text)
	
	
	

	
#func hide_button():
	#$StartButton.hide()
	#$Water.hide()
	#$Humidity.hide()
	#$Cloud.hide()
	#$Temperature.hide()
#	$StartButton.show()
#	$StartButton.text="Stop"
#	pass
func _on_message_timer_timeout():
	$Message.hide()
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func manage_game(new_game):
	$StartButton.show()
	


func _on_stop_game() -> void:
	show_game_over()
	pass # Replace with function body.


func _on_start_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$StartButton.text="stop"
		tooglebutton="stop"	
		start_game.emit()
		#$StartButton.hide()
		$Water.hide()
		$Humidity.hide()
		$Cloud.hide()
		$Temperature.hide()
		print("start")
	
	else:
		$StartButton.text="Stop"
		tooglebutton="play"
		stop_game.emit()
		print("stop")
		
	print($Water.text)
	pass # Replace with function body.

func get_variables():
	var measurements={"water":$Water,"humidity":$Humidity,"cloud":$Cloud,"temperature":$Temperature}
	var measurementsValues={"water":0,"humidity":0,"cloud":0,"temperature":0}
	for key in measurements:
		if(measurements[key].text==""):
			
			measurements[key].text="23"
			measurementsValues[key]=float(23)
			
		else:
			measurementsValues[key]=float(measurements[key].text)
	
	return measurementsValues
	
