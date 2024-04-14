extends ColorRect


signal retry()
signal next_level()

@onready var retry_btn = %RetryBtn
@onready var map_btn = %MapBtn


var level_score = 0
var displayed_totalScore = 0
var displayed_score = 0

func _on_retry_btn_pressed():
	retry.emit()



var score_counted_emitted = false
signal score_counted()

func _ready():
	set_process(false)
	score_counted.connect(after_score_counted)
	

func _process(_delta):
<<<<<<< HEAD
	if displayed_score != level_score and level_score - displayed_score <= 10:
		displayed_score += 1
=======
	if displayScore != Globals.level_score and level_score - displayScore <= 10:
		displayScore += 1
>>>>>>> 862e4b88e92be7211188ca335e5cdca69a93c054
		
	if displayed_score != level_score and level_score - displayed_score <= 100 and level_score - displayed_score > 10:
		displayed_score += 3
	
	if displayed_score != level_score and level_score - displayed_score <= 1000 and level_score - displayed_score > 100:
		displayed_score += 11
		
	if displayed_score != level_score and level_score - displayed_score > 1000:
		displayed_score += 41
		
	if displayed_score != level_score and level_score - displayed_score > 10000:
		displayed_score += 121
		
	if displayed_score != level_score and level_score - displayed_score > 25000:
		displayed_score += 251
		
	
	%"Level Score Label".text = str(displayed_score)
	%"Total Score Label".text = str(displayed_totalScore)
	
	
	
	if not score_counted_emitted and displayed_score == level_score:
		score_counted.emit()
		score_counted_emitted = true
		
	
	


func exit_reached():
	print(LevelTransition.get_node("%saved_progress").get("state_" + str(Globals.current_level)))
	level_score = Globals.level_score
	
	if not Globals.mode_scoreAttack:
		if get_tree().get_nodes_in_group("Collectibles").size() == 0:
			if LevelTransition.get_node("%saved_progress").get("state_" + str(Globals.current_level)) < 3:
				LevelTransition.get_node("%saved_progress").set("state_" + str(Globals.current_level), 3)
				
		elif get_tree().get_nodes_in_group("specialCollectible").size() <= 0:
			if LevelTransition.get_node("%saved_progress").get("state_" + str(Globals.current_level)) < 2:
				LevelTransition.get_node("%saved_progress").set("state_" + str(Globals.current_level), 2)
				
		elif get_tree().get_nodes_in_group("Collectibles").size() >= 0:
			if LevelTransition.get_node("%saved_progress").get("state_" + str(Globals.current_level)) < 1:
				LevelTransition.get_node("%saved_progress").set("state_" + str(Globals.current_level), 1)
		
		if LevelTransition.get_node("%saved_progress").get("score_" + str(Globals.current_level)) < level_score:
			LevelTransition.get_node("%saved_progress").set("score_" + str(Globals.current_level), level_score)
	
	
	
	
		if Globals.selected_episode == "rooster_island":
			if Globals.current_level_ID == LevelTransition.get_node("%saved_progress").next_level_RI1:
				LevelTransition.get_node("%saved_progress").next_level_RI1 += 1
				
		elif Globals.selected_episode == "rooster_island_2":
			if Globals.current_level_ID == LevelTransition.get_node("%saved_progress").next_level_RI2:
				LevelTransition.get_node("%saved_progress").next_level_RI2 += 1
	
	
	
		Globals.save_progress.emit()
	
	
	
	
	
	
	$AudioStreamPlayer.play()
	$level_finished_text_hide.start()
	await $level_finished_text_hide.timeout
	await LevelTransition.fade_to_black()
	%"Level Finished Label".visible = false
	%"Button Container".visible = true
	%Background.visible = true
	%"End Screen".visible = true
	%"End Screen Values".visible = true
	await LevelTransition.fade_from_black_slow()
	%MapBtn.grab_focus()
	
	set_process(true)
	
	




var mapScreen = load("res://map_screen.tscn")

func _on_map_btn_pressed():
	#next_level.emit()
	
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(mapScreen)
	await LevelTransition.fade_from_black_slow()






func after_score_counted():
	if Globals.current_levelSet_ID == "MAIN":
		LevelTransition.get_node("%saved_progress").count_total_score(Globals.current_levelSet_ID, 13)
	
	await get_tree().create_timer(1, true).timeout
	displayed_totalScore = LevelTransition.get_node("%saved_progress").get("total_score_" + Globals.current_levelSet_ID)
	#print(LevelTransition.get_node("%saved_progress").get("total_score_" + Globals.current_levelSet_ID))
	#print(("total_score_" + Globals.current_levelSet_ID))
	
	#if mode is something: then count various stuff and give points for them
		#await get_tree().create_timer(0.5, true).timeout
		#count_hp()
		#await get_tree().create_timer(0.5, true).timeout
		#count_inventoryItems()



var displayedBonus_hp = 0
var displayedBonus_time = 0
var displayedBonus_items = 0

func count_hp():
	while Globals.playerHP > 0:
		print(Globals.playerHP)
		Globals.playerHP -= 1
		displayedBonus_hp += 1000
		await get_tree().create_timer(0.5, true).timeout


func count_inventoryItems():
	if Globals.inventory_currentItemCount > 0:
		displayedBonus_items + 1000
		