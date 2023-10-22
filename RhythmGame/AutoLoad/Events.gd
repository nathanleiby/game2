extends Node

## emitted every time we move a half-beat forward in the song
## msg is a Dictionary of info
signal half_beat_incremented(msg)

# Emitted when the player made an action that increases the score
signal scored(msg)

signal track_finished
