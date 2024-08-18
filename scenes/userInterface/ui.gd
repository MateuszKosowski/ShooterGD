extends CanvasLayer

var red: Color = Color(0.9,0.0,0.0,1.0)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GranadeCounter/VBoxContainer/Label

func update_laser_text():
	laser_label.text = str(Globals.laser_amount) + "/50"
	if Globals.laser_amount == 0:
		laser_label.modulate = red
		$LaserCounter/VBoxContainer/MarginContainer/TextureRect.modulate = red
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount) + "/5"
	if Globals.grenade_amount == 0:
		grenade_label.modulate = red
		$GranadeCounter/VBoxContainer/MarginContainer/TextureRect.modulate = red
