extends Node

var save_data = {}

func loadFile(filePath):
	var save_file = File.new()
	save_file.open(filePath, File.READ)
	var save_file_json = JSON.parse(save_file.get_as_text())
	save_file.close()
	save_data = save_file_json.result
	PlayerAttributes.setData(save_data["Inventory"], save_data["Equipment"], save_data)


func saveFile(filePath):
	var file
	file = File.new()
	file.open(filePath, File.WRITE)
	file.store_line(to_json(save_data))
	file.close()


func newGame():
	save_data = {
  "Equipment": {
	"Accessory": null,
	"Chest": null,
	"Feet": null,
	"Hand": null,
	"Head": null,
	"Legs": null,
	"MainHand": null,
	"OffHand": null
  },
  "Inventory": {
	"Inv01": {
	  "Item": null,
	  "Stack": null
	},
	"Inv02": {
	  "Item": null,
	  "Stack": null
	},
	"Inv03": {
	  "Item": null,
	  "Stack": null
	},
	"Inv04": {
	  "Item": null,
	  "Stack": null
	},
	"Inv05": {
	  "Item": null,
	  "Stack": null
	},
	"Inv06": {
	  "Item": null,
	  "Stack": null
	},
	"Inv07": {
	  "Item": null,
	  "Stack": null
	},
	"Inv08": {
	  "Item": null,
	  "Stack": null
	},
	"Inv09": {
	  "Item": null,
	  "Stack": null
	},
	"Inv10": {
	  "Item": null,
	  "Stack": null
	},
	"Inv11": {
	  "Item": null,
	  "Stack": null
	},
	"Inv12": {
	  "Item": null,
	  "Stack": null
	},
	"Inv13": {
	  "Item": null,
	  "Stack": null
	},
	"Inv14": {
	  "Item": null,
	  "Stack": null
	},
	"Inv15": {
	  "Item": null,
	  "Stack": null
	},
	"Inv16": {
	  "Item": null,
	  "Stack": null
	},
	"Inv17": {
	  "Item": null,
	  "Stack": null
	},
	"Inv18": {
	  "Item": null,
	  "Stack": null
	},
	"Inv19": {
	  "Item": null,
	  "Stack": null
	},
	"Inv20": {
	  "Item": null,
	  "Stack": null
	},
	"Inv21": {
	  "Item": null,
	  "Stack": null
	},
	"Inv22": {
	  "Item": null,
	  "Stack": null
	},
	"Inv23": {
	  "Item": null,
	  "Stack": null
	},
	"Inv24": {
	  "Item": null,
	  "Stack": null
	},
	"Inv25": {
	  "Item": null,
	  "Stack": null
	}
  }
}
	PlayerAttributes.setData(save_data["Inventory"], save_data["Equipment"], save_data)
