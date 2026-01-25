extends Resource

class_name SettingsEditor

const SAVE_PATH = "user://Editor/Settings.tres"

func save_settings():
	# Nos aseguramos de que la carpeta exista
	if not DirAccess.dir_exists_absolute("user://Editor/"):
		DirAccess.make_dir_recursive_absolute("user://Editor/")
	
	var error = ResourceSaver.save(self, SAVE_PATH)
	if error != OK:
		printerr(" Error al guardar settings: ", error)

## Función para cargar (puedes llamarla desde un Singleton o el Root)
static func load_settings() -> SettingsEditor:
	if ResourceLoader.exists(SAVE_PATH):
		return load(SAVE_PATH)
	
	return SettingsEditor.new() # Retorna valores por defecto
