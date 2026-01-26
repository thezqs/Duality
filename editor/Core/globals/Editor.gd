extends Node
## Un Script global que gestiona constantes, variables de el editor.
## Este Script global tambien tiene funciones auxiliares.

## Ruta a la carpeta de plugins
const PLUGIN_PATH = "user://plugin"

const STEP_PX: int = 50

signal error(message: String)

var song: SongResource

var settings: SettingsEditor

func start_edit(song_edit: SongResource):
	song = song_edit
	
	settings = SettingsEditor.load_settings()

func stop_edit():
	song = null

## Retorna todos los plugins encontrados en [PLUGIN_PATH]
func get_plugins(base_path: String = PLUGIN_PATH) -> Array:
	var plugins_encontrados = []
	
	if not DirAccess.dir_exists_absolute(base_path):
		DirAccess.make_dir_absolute(base_path)

	var dir = DirAccess.open(base_path)
	if dir:
		dir.list_dir_begin()
		var item_name = dir.get_next()
		
		while item_name != "":
			if item_name.begin_with("."): 
				item_name = dir.get_next()
				continue
			
			var full_path = base_path.path_join(item_name)
			
			# ESCENARIO A: El plugin es una carpeta
			if dir.current_is_dir():
				# Buscamos dentro de ESA carpeta el archivo Main
				var sub_dir = DirAccess.open(full_path)
				if sub_dir:
					sub_dir.list_dir_begin()
					var sub_file = sub_dir.get_next()
					while sub_file != "":
						# Buscamos que sea .tscn y que contenga "Main"
						if sub_file.ends_with(".tscn") and sub_file.contains("Main"):
							plugins_encontrados.append(full_path.path_join(sub_file))
							break # Ya encontramos el principal, saltamos al siguiente plugin
						
						sub_file = sub_dir.get_next()
			
			# ESCENARIO B: El plugin es un archivo suelto en la raíz de plugins
			else:
				if item_name.ends_with(".tscn") and item_name.contains("Main"):
					plugins_encontrados.append(full_path)
			
			await get_tree().process_frame

			item_name = dir.get_next()
		dir.list_dir_end()
	
	return plugins_encontrados

func get_loops():
	pass

func editor_printerr(args: Array):
	var err = array_to_string(args)
	error.emit(err)
	printerr(err)

func array_to_string(array: Array) -> String:
	var string = ""
	for i in range(array.size()):
		string += str(array[i])
		if i < array.size() - 1:
			string += " "
	return string
