# calculator-case
openscad design of case for sinclair scientific emulator

## Files
- *case.scad* the main design
- *definitons.scad* all measurements
- *plugs.scad* simple plugs to hold the PCB in place (through mounting holes)
- stl:
  - v1: original, native inches
  - v2: scaled up to use native mm
  - v3: adjustments after first print

## Notes

### Initial prototype (v1/2)

Couple of issues.

- Slot for PCB isn't quite tall enough to fit the soldered leads. The PCB itself fits nicely. I think I should have a two-layer design: keep the slot as is, but then depress the back a bit so the leads have room.
- Battery is just entirely in the wrong place. I don't think I actually ever measured it.
- Plugs are way too small. I think I should try squares or ovals so that there's some room for form-fitting.
