extends Resource

## Un recurso especial para las canciones
class_name SongResource

## Todas las dificultades disponibles para elegir.
## SD es facil, HD es medio, 4K (cuatro k) es dificil y 8K (ocho k) es insano
enum DIFFICULTIES {SD,HD, FOUR_K, EIGHT_K}

@export_category("general")

## El nombre de la cancion
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
## Nota: Para acceder a un loop tienes que pasarle un ID ([int])
## y esto te dara un [AanimationLoop]
@export var loops_libary: Dictionary = {}

## La secuencia de loops 
@export var loop_sequence: Array[Array] = []

@export_category("chart")

## Se usa para acceder a las notas de las lineas. 
## Nota: Se accede con el ID de una linea ([int]) y te retorna un [Dictionary]
## que si ingresas el tiempo de la nota ([float]) en segundos te retorna la posicion X de la nota.
@export var lines: Dictionary = {}

## Se usa para acceder a las notas de las torres. 
## Nota: Se accede con el ID de una torre ([int]) y te retorna un [Array] que contiene 
## el tiempo ([float]) en segundos de cada nota.
@export var towers: Dictionary = {}
