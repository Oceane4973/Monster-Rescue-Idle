extends Area3D

#Référence : https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
const SAVE_GAME_PATH := "user://savegame.save"
const move_speed := 4.0
var player_data : PlayerData = null
var ui_data : UiData = null
@onready var monsters_popup = $UI/Control/MonstersPopup
@onready var buildings_popup = $UI/Control/BuildingPopup
#@onready var chemin = $CheminVisiteurs
@export var chemin: Path3D

# Called when the node enters the scene tree for the first time.
func _ready():
	ui_data = get_node("/root/UiData")
	player_data = get_node("/root/PlayerData")
	ui_data.chemin = chemin
	loadGame();

func _physics_process(delta):
	# Référence : https://forum.godotengine.org/t/how-to-get-all-children-from-a-node/18587
	for _i in chemin.get_children():
		_i.progress += move_speed * delta

func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST || what == NOTIFICATION_WM_GO_BACK_REQUEST:
		saveGame()

func save_file_exists() -> bool:
	return FileAccess.file_exists(SAVE_GAME_PATH)

func saveGame() -> void:
	var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)
	var player_data_json_string = JSON.stringify(player_data.save());
	save_game.store_line(player_data_json_string)
	print("Saving succeeded")

func loadGame() -> void:
	if save_file_exists() == false:
		print("Save file doesn't exist : we're creating it")
	else:
		# We need to revert the game state so we're not cloning objects
		# during loading. This will vary wildly depending on the needs of a project, so take care with this step.
		# For our example, we will accomplish this by deleting saveable objects.
		var save_nodes = get_tree().get_nodes_in_group("Persist")
		for i in save_nodes:
			i.queue_free()

		# Load the file line by line and process that dictionary to restore the object it represents.
		var save_game = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		while save_game.get_position() < save_game.get_length():
			var json_string = save_game.get_line()

			# Creates the helper class to interact with JSON
			var json = JSON.new()

			# Check if there is any error while parsing the JSON string, skip in case of failure
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue

			# Get the data from the JSON object
			var node_data = json.get_data()
			
			# Verify if it's a global class
			if(!node_data.has("filename")):
				for i in node_data.keys():
					player_data.set(i, node_data[i])
				continue
			
			# Firstly, we need to create the object and add it to the tree and set its position.
			var new_object = load(node_data["filename"]).instantiate()
			get_node(node_data["parent"]).add_child(new_object)
			if "pos_x" in node_data && "pos_y" in node_data && "pos_z" in node_data:
				new_object.position = Vector3(node_data["pos_x"], node_data["pos_y"], node_data["pos_z"])

			# Now we set the remaining variables.
			for i in node_data.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "pos_z":
					continue
				new_object.set(i, node_data[i])
				
	monsters_popup.instantiate_view()
	buildings_popup.instantiate_view()
	load_monsters()

func load_monsters():
	for monster in player_data.list_Of_Monsters :
		for nb in monster.currentNB :
			_add_monster(monster)
		
func _add_monster(monster : Monster):
	var assets = load(monster.model_src).instantiate();
	var suivi_chemin: PathFollow3D = PathFollow3D.new()
	var value_progress: float = randi_range(0, 100)
	suivi_chemin.progress = value_progress
	suivi_chemin.loop = true;
	suivi_chemin.add_child(assets)
	chemin.add_child(suivi_chemin)
