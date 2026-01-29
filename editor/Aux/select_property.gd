extends PanelContainer

class_name SelectPropertyPanel

## Abre la lista de propiedades y te devuelve la propiedad seleccionada por el usuario
func up(object: Object, start_from_class: String = "Node2D", filter: bool = true) -> Dictionary:
	visible = true
	%ItemList.clear()
	
	var valid_properties: Array[Dictionary] = []
	var property_list: Array[Dictionary] = object.get_property_list()
	
	var script_path: String = object.get_script().resource_path
	var script_name: String = script_path.get_file()
	
	var found_start: bool = false
	
	for property in property_list:
		if filter: # si se quiere filtrar, se filtra
			# Si esta propiedad es un flag de clase (osea, el inicio de las propiedades de una clsae)
			if property.usage == 128:
				found_start = property.name == start_from_class or property.name == script_name
			
			if not found_start: continue
		
		# si la propiedad es una variable exportada o algo de el motor que se pueda editar...
		if property.usage == 4102 or property.usage == 6:
			valid_properties.append(property)
			%ItemList.add_item(property.name)
			
			# para evitar congelar la UI en casos extremos, esperamos un fotograma (de igual forma ni se siente XD)
			await get_tree().process_frame
	
	var idx = await %ItemList.item_activated
	
	visible = false
	return valid_properties[idx]
