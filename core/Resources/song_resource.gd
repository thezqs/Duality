extends Resource
## Un recurso especial para las canciones
class_name SongResource

## Todas las dificultades disponibles para elegir.
## SD es facil, HD es medio, 4K (cuatro k) es dificil y 8K (ocho k) es insano
enum DIFICULTADES {SD,HD, CUATRO_K, OCHO_K}

@export_category("general")

## El nombre ded la cancion
@export var song_name: String

## El nombre de el artista que hizo la cancion
@export var artist_name: String

## El nombre de quien creo el chart
@export var chart_of: String

## La textura de la portada para la cancion
@export var cover: Texture2D

## El audio de la cancion
@export var audio: AudioStream

## La dificultad
@export var dificultad: DIFICULTADES

@export_category("animation")

## Todos los loops contenidos.
@export var loops_libary: Dictionary = {}

## La secuencia de loops 
@export var loop_sequence: Array[Array] = []
