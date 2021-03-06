extends Node2D

var output = []
var path_server = 'C:\\Users\\survi\\OneDrive\\Desktop\\server speedrun\\'
var window_title = "MinecraftServer"
var min_ram = 1
onready var max_ram = $Controls/MaxMemorySlider.value

# Nodes
onready var start_button = $Controls/StartButton
onready var stop_button = $Controls/StopButton
onready var reset_button = $Controls/ResetButton
onready var seed_line_edit = $Controls/SeedLineEdit
onready var current_path_label = $CurrentPath



# Unused code
#	var tasklist_output
#	OS.execute("cmd", ["/C", "tasklist /FI \"WINDOWTITLE eq MinecraftServer\""], true, tasklist_output)
#	print(tasklist_output)


func _ready():
	current_path_label.text = path_server
	#print(properties)


func start_server():
	if seed_line_edit.text != "":
		pass
	OS.execute('cmd', ['/C', "cd %s && start.bat %s %s %s" % [path_server, window_title, min_ram, max_ram]], false, output)

func kill_server():
	OS.execute("cmd", ["/C", "taskkill /FI \"WINDOWTITLE eq %s\""%window_title])


func delete_world_folder():
	var world_file = path_server+"world\\"
	OS.execute("cmd", ["/C", "rmdir \"%s\" /s /q" % world_file])




func _on_ResetButton_pressed():
	kill_server()
	yield(get_tree().create_timer(1), "timeout")
	delete_world_folder()
	yield(get_tree().create_timer(1), "timeout")
	start_server()


func _on_StartButton_pressed():
	start_server()

func _on_StopButton_pressed():
	kill_server()


func _on_MaxMemorySlider_value_changed(value):
	$Controls/MemoryLabel.text = "Max Memory (GB): " + str(value)
	max_ram = value


func _on_PropertiesButton_toggled(button_pressed):
	if button_pressed:
		$Controls.hide()
		$PropertiesPanel.show()
	else:
		$Controls.show()
		$PropertiesPanel.hide()
