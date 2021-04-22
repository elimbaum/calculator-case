# calculator-case
openscad design of case for sinclair scientific emulator ([tindie][1], [hackaday][2], [github][3])

[1]: https://www.tindie.com/products/simpleavr/ti-msp430-emulating-calculator-kit/#product-description
[2]: https://hackaday.io/project/167780-ti-msp430-emulating-calculator
[3]: https://github.com/simpleavr/tms0800

## Files
- **case.scad** the main design
- **definitons.scad** all measurements
- **plugs.scad** simple plugs to hold the PCB in place (through mounting holes)
- stl:
  - v1: original, native inches
  - v2: scaled up to use native mm
  - v3: adjustments after first print

## Notes

### Special keycodes
I always forget these and get stuck. Copying them here to prevent that.

- C+5 = button test ('C'+'C' to end test)
- C+6 = secret message edit (+ key to advance) *(eli note: to cancel, press + key a bunch)*
- C+7 = toggle datamath / sinclair roms
- C+8 = toggle slow / fast cpu
- C+9 = show secret message
- C+C = turn off (put to sleep)

### Initial prototype (v1/2)

Couple of issues.

- Slot for PCB isn't quite tall enough to fit the soldered leads. The PCB itself fits nicely. I think I should have a two-layer design: keep the slot as is, but then depress the back a bit so the leads have room.
- Battery is just entirely in the wrong place. I don't think I actually ever measured it.
- Plugs are way too small. I think I should try squares or ovals so that there's some room for form-fitting.

I'm thinking of writing a function that takes care of adjustments for me:

```scad
LENGTH = 5;
// becomes
LENGTH = adj(orig=5, meas=5.1);
```

Nah, maybe not worth it.

Plugs were supposed to be diameter 0.125, and are more like 0.115. Holes came out right, however (0.135). I want to make the plugs ellipses, so the major axis should be a bit too big and the minor a bit small. This may need further adjustment, but I can always hack this together, or just print new ones.
