extends Control


onready var main = get_parent()
var properties

onready var seed_line = $VBoxContainer/SeedHBox/LineEdit
onready var motd_line = $VBoxContainer/MotdHBox/LineEdit


func _ready():
	properties = get_properties()
	set_property("level-seed", "")
	seed_line.text = get_property_value("level-seed")
	motd_line.text = get_property_value("motd")
	
func get_properties():
	var file = File.new()
	file.open(main.path_server+"server.properties", File.READ)
	var str_return = file.get_as_text()
	file.close()
	return str_return


func set_property(property:String, value:String):
	properties = properties.replace(get_property_line(property), property+"="+value)
	var file = File.new()
	file.open(main.path_server+"server.properties", File.WRITE)
	file.store_string(properties)
	file.close()

func get_property_value(property:String):
	return get_property_line(property).split("=")[1]

func get_property_line(property:String):
	var substring = properties.split("\n")
	for i in substring:
		if property in i:
			return i


func _on_SeedLine_text_changed(new_text):
	set_property("level-seed", new_text)

func _on_MotdEdit_text_changed(new_text):
	set_property("motd", new_text)
