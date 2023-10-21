## Notes

- bps and hbps aren't correct naming, i think. should be "beat **duration**" and half-beat duration. (music wise, quarter note and eighth note would make more sense, but I can see how we may be trying to avoid those names)
- Godot 4
  - tweens have changed
  - event connecting has changed .. this syntax is closest to the old, and lets you pass a function as an argument (hooray!) `Events.connect("beat_incremented", _spawn_beat)` ([reference](https://gdquest.mavenseed.com/community/17073-notes-for-godot-4))
