extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GranadeCounter/VBoxContainer/Label

func update_laser_text():
	laser_label.text = str(Globals.laser_amount) + "/50"
	
func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount) + "/5"
