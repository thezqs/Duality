extends PanelContainer

## Es un nodo que funciona como un track de animacion.
## Tiene Optiones para colocar claves (keys), para eliminarlas, para cambiar el color, etc.
class_name Track

#region variables

## Variable de ruta para el Popup que cambia el color
@onready var _popup_color: PopupPanel = $PopupColor

## Variable de ruta para el Popup que se hace visible con el clic derecho
@onready var _popup_clic_2: PopupPanel = $PopupClic2

## Variable de ruta para el ColorPicker que se utiliza para el Popup que cambia el color
@onready var color_picker: ColorPicker = $PopupColor/VBoxContainer/ScrollContainer/VBoxContainer/ColorPicker


## El ID de el track. Esta variable es de solo lectura.
var id: String = "Track":
	set(new):
		id = name
		$FoldableContainer.title = id
		$PopupClic2/VBoxContainer/TrackNameLabel.text = id

#endregion

## Señales ##

## Se emite cuando hay un requisito para eliminar el track.
signal delete_request(id)

## Se emite cuando hay un requisito para duplicar el track
signal duplicate_request(id)

## Se emite cuando algo ha cambiado en el track.
signal change(id)

## Funciones ocultas ##

func _ready() -> void:
	id = name

func _on_foldable_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_popup_clic_2.popup()
			_popup_clic_2.position = event.global_position

#region Clic 2 PopUp

func _on_change_color_button_pressed() -> void:
	_popup_color.popup_centered()
	_popup_clic_2.hide()

func _on_duplicate_button_pressed() -> void:
	duplicate_request.emit()
	_popup_clic_2.hide()

func _on_delete_button_pressed() -> void:
	delete_request.emit()
	_popup_clic_2.hide()

func _on_change_name_button_pressed() -> void:
	$ChangeNamePopup.popup_centered()
	$ChangeNamePopup/VBoxContainer/ChangeNameLineEdit.text = name
	_popup_clic_2.hide()

#endregion

#region Color PopUp

func _on_cancel_pressed() -> void:
	_popup_color.hide()

func _on_acept_pressed() -> void:
	$FoldableContainer.modulate = color_picker.color
	self_modulate = color_picker.color
	_popup_color.hide()

#endregion

#region Change Name Popup

func _on_cancel_button_name_pressed() -> void:
	$ChangeNamePopup.hide()

func _on_acept_button_name_pressed() -> void:
	name = $ChangeNamePopup/VBoxContainer/ChangeNameLineEdit.text
	id = name
	$ChangeNamePopup.hide()

 #endregion
