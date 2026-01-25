extends Node
## Un Script global que gestiona constantes, variables de el editor.
## Este Script global tambien tiene funciones auxiliares.

const STEP_PX: int = 50

var song: SongResource

func start_edit(song_edit: SongResource):
	song = song_edit

func stop_edit():
	song = null
