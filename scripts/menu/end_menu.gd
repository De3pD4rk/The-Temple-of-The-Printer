extends Control

func _ready() -> void:
	# Time funnies
	var timeFunny = ""
	if Global.playtime < 30:
		timeFunny = "That was some speedrunner-like matterial, any% who?"
	elif Global.playtime >= 30 and Global.playtime < 90:
		timeFunny = "Not bad, not bad"
	elif Global.playtime >= 90 and Global.playtime < 180:
		timeFunny = "That was pretty average, but ok i guess"
	elif Global.playtime >= 180 and Global.playtime < 360:
		timeFunny = "This game is pretty easy, don't know how this happened"
	else:
		timeFunny = "Hum, did you fell asleep or something?"
	
	var minutes = int(Global.playtime) / 60
	var seconds = int(Global.playtime) % 60
	$Texts/Time.text = "You completed the game in %02d:%02d" % [minutes, seconds] + ". "  + timeFunny
	
	# Deaths funnies
	var deathsFunny = ""
	if Global.death_counter < 1:
		deathsFunny = "No deaths? Give this human a pro contract right now"
	elif Global.death_counter >= 1 and Global.death_counter < 4:
		deathsFunny = "Pretty good, a few more tries and you'll be a pro"
	elif Global.death_counter >= 4 and Global.death_counter < 10:
		deathsFunny = "Fair enough"
	elif Global.death_counter >= 10 and Global.death_counter < 15:
		deathsFunny = "This is a little embarassing, I have to say"
	else:
		deathsFunny = "You usually don't play video games, right? RIGHT?"
	
	$Texts/Deaths.text = "You died " + str(Global.death_counter) + " times! " + deathsFunny
		
	# Coins funnies
	var coinsFunny = ""
	if Global.coins < 1:
		coinsFunny = "Really? How did you manage this?"
	elif Global.coins >= 1 and Global.coins < 15:
		coinsFunny = "You caught these by accident, didn't you?"
	elif Global.coins >= 15 and Global.coins < 30:
		coinsFunny = "Decent effort, but you could have tried harder"
	elif Global.coins >= 30 and Global.coins < 50:
		coinsFunny = "I see we have a collectable enjoyer here, very good"
	else:
		coinsFunny = "You must be bathing in gold coins in this moment, amazing"
		
	$Texts/Coins.text = "You collected " + str(Global.coins) + " coins! " + coinsFunny
	
	# Kills funny
	var killsFunnies = ""
	if Global.coins < 1:
		killsFunnies = "You tried to speedrun the game, didn't you?"
	elif Global.coins >= 1 and Global.coins < 5:
		killsFunnies = "Not to be rude, but ever played a shooter before?"
	elif Global.coins == 5:
		killsFunnies = "PENTAKILL"
	elif Global.coins >= 6 and Global.coins < 10:
		killsFunnies = "Bad aim, I get it. But decent effort though"
	elif Global.coins >= 10 and Global.coins < 20:
		killsFunnies = "No enemy stands a change against you"
	else:
		killsFunnies = "Terminator? Is that you?"
		
	$Texts/Kills.text = "You killed " + str(Global.kills) + " enemies! " + killsFunnies

func _on_play_again_pressed() -> void:
	Global.coins = 0
	Global.death_counter = 0
	Global.kills = 0
	Global.playtime = 0
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
