extends Resource
## Un recurso especial para las canciones
class_name SongResource

## Todas las dificultades disponibles para elegir.
## SD es facil, HD es medio, 4K (cuatro k) es dificil y 8K (ocho k) es insano
enum DIFFICULTIES {SD,HD, FOUR_K, EIGHT_K}

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
@export var difficulty: DIFFICULTIES

## El bpm de la cancion
@export var bpm: int = 120

@export_category("animation")

## Todos los loops contenidos.
@export var loops_libary: Dictionary = {}

## La secuencia de loops 
@export var loop_sequence: Array[Array] = []

@export_category("chart")

## Se usa para acceder a las notas de las lineas.
## Se accede con el ID de una linea (int) y te retorna un array que contiene 
## el tiempo (float) y la posicion (float) de la nota.
@export var lines: Dictionary = {}

## Se usa para acceder a las notas de las torres.
## Se accede con el ID de una torre (int) y te retorna un array que contiene 
## el tiempo (float) de la nota.
@export var towers: Dictionary = {}
