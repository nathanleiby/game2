# game 2: "Godot Rhythm Game"

from https://gdquest.mavenseed.com/courses/godot-2d-secrets

## Notes

- bps and hbps aren't correct naming, i think. should be "beat **duration**" and half-beat duration. (music wise, quarter note and eighth note would make more sense, but I can see how we may be trying to avoid those names)
- Godot 4

  - tweens have changed
  - event connecting has changed .. this syntax is closest to the old, and lets you pass a function as an argument (hooray!) `Events.connect("beat_incremented", _spawn_beat)` ([reference](https://gdquest.mavenseed.com/community/17073-notes-for-godot-4))
  - Position2D node is now Marker2D
  - for https://gdquest.mavenseed.com/lessons/animated-scoring-sprites
  - https://www.reddit.com/r/godot/comments/zdcwwg/where_did_the_position2d_node_go/
  - Particles2D -> CPU or GPU particles .. Needed GPU to have process material https://docs.godotengine.org/en/stable/classes/class_particleprocessmaterial.html
  - `.instance()` -> `.instantiate()`

- I had to mouse ignore the ColorRect (which wraps the shader), else it was blocking clicks on the HitBeat. Seems strange since it's behind the sprite, but not sure
- I accidentally shadowed a variable (var shrink_speed) instead of using the global value. GodotScript then allowed me to do math using the global value which was unset, thus gave a 0 value.. didn't shrink :(
- can spawn game wherever you want on screen (or a 2nd screen) https://www.reddit.com/r/godot/comments/ijqtoa/godot_development_with_ultrawide_monitors/

Questions

- mouse "filter" -> ignore seems like a tricky thing to find if it's broken... is there a quick way to see what's catching input events?

Next Steps

- Playable on Itch
- Add Hit Roller mechanic -- https://gdquest.mavenseed.com/lessons/the-roller-mechanic -- skipped in tutorial for now
- To make this game playable, need good patterns.
  - idea: analyze the audio to make good patterns
  - improve the editor + DIY (or use an existing editor and export to this game)
