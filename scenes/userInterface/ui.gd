extends CanvasLayer

var red: Color = Color(0.9,0.0,0.0,1.0)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GranadeCounter/VBoxContainer/Label
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("health_change", update_health_text)
	update_laser_text()
	update_grenade_text()
	update_health_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount) + "/50"
	if Globals.laser_amount == 0:
		laser_label.modulate = red
		$LaserCounter/VBoxContainer/MarginContainer/TextureRect.modulate = red
	else:
		laser_label.modulate = Color(1, 1, 1)
		$LaserCounter/VBoxContainer/MarginContainer/TextureRect.modulate = Color(1, 1, 1)
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount) + "/5"
	if Globals.grenade_amount == 0:
		grenade_label.modulate = red
		$GranadeCounter/VBoxContainer/MarginContainer/TextureRect.modulate = red
	else:
		grenade_label.modulate = Color(1, 1, 1)
		$GranadeCounter/VBoxContainer/MarginContainer/TextureRect.modulate = Color(1, 1, 1)

func update_health_text():
	health_bar.value = Globals.health
