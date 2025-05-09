extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.info_sign_touched.connect(show_info)


#var displaying = false
var current_text = str(Globals.infoSign_current_text)
var current_size = Globals.infoSign_current_size

func show_info():
	#if not displaying:
	#displaying = true
	
	current_text = str(Globals.infoSign_current_text)
	current_size = Globals.infoSign_current_size
	%info_text.text = str(current_text)
	
	if current_size == 0:
		$"../AnimationPlayer".play("show_0")
	elif current_size == 1:
		$"../AnimationPlayer".play("show_1")
	elif current_size == 2:
		$"../AnimationPlayer".play("show_2")
	elif current_size == 3:
		$"../AnimationPlayer".play("show_3")
	
	
	$"../Timer".start()


func _on_timer_timeout():
	if current_size == 0:
		$"../AnimationPlayer".play("hide_0")
	elif current_size == 1:
		$"../AnimationPlayer".play("hide_1")
	elif current_size == 2:
		$"../AnimationPlayer".play("hide_2")
	elif current_size == 3:
		$"../AnimationPlayer".play("hide_3")
