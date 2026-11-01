# STORM HAMMER — 4WD combat robot chassis

Complete 3D model and cutting files, generated parametrically. Units: **millimetres**,
scale 1:1. Origin (0,0,0) = rear-left corner, bottom face of the base plate.
X = 0→305 (rear to front), Y = 0→254 (left to right), Z = up.

```
stormhammer/
├── STORMHAMMER_3D.scr      AutoCAD script — builds the whole 3D solid model by itself
├── stormhammer.scad        OpenSCAD parametric source (change one number, everything updates)
├── dxf/                    flat cutting profiles, one file per plate (laser/waterjet/plasma)
├── stl/                    3D meshes — chassis only, full assembly, and every part separately
└── README.md
```

## How to use each file

**AutoCAD (what your teammate wanted).** Open a new metric drawing (`acadiso.dwt`),
type `SCRIPT`, pick `STORMHAMMER_3D.scr`, press Enter and don't touch the mouse.
It sets units, turns off dynamic input and osnap (the thing that broke the polylines
before), then draws, extrudes and boolean-subtracts all 12 plates into a finished 3D
solid model with the blade, wheels and battery as reference bodies on layer `REF`.
Afterwards run `INTERFERE` to check clashes and `MASSPROP` on any solid for its weight.

**OpenSCAD** (free, 20 MB). Open `stormhammer.scad`, F5 to preview, F6 to render,
then File → Export → STL. Set `explode = 40;` at the top for an exploded view, or
`show_components = false;` for bare frame. Every dimension is a variable at the top.

**The metal shop.** Send the 7 files in `dxf/` — they are closed polylines with the
holes as true circles, already in mm. Quantities and materials are in the table below.

**3D printer / checking fit.** `stl/stormhammer_full_assembly.stl` is the whole bot.
Scale 25% for a desk mock-up.

## Cut list

| # | DXF file | Qty | Material | Thickness | Blank size |
|---|---|---|---|---|---|
| 1 | `1_BASE_PLATE.dxf` | 1 | Aluminium 6061-T6 | 3.0 mm | 305 × 254 |
| 8 | `8_BULKHEAD_DOUBLER.dxf` | 1 | Aluminium 6061-T6 | 3.0 mm | 160 × 65 |
| 2 | `2_SIDE_PANEL_x2.dxf` | 2 | Aluminium 6061-T6 | 3.0 mm | 305 × 90 |
| 3 | `3_BULKHEAD_x2.dxf` | 2 | Aluminium 6061-T6 (wood-reinforced per builder) | 4.0 mm | 160 × 84 |
| 4 | `4_REAR_WALL.dxf` | 1 | Aluminium 6061-T6 | 2.0 mm | 254 × 65 |
| 5 | `5_GROUND_FORK_x2.dxf` | 2 | Aluminium 6061-T6 (wood-reinforced per builder) | 6.0 mm | 120 × 45 |
| 6 | `6_TOP_COVER_x2.dxf` | 2 | Aluminium | 1.5 mm | 140 × 118 |
| 7 | `7_NOSE_COVER_x2.dxf` | 2 | Aluminium | 2.0 mm | 166.4 × 118 |

Frame mass as specified (Al base + steel walls + Al covers): **≈ 3.0 kg**.
All-aluminium: **1.71 kg**. All-steel: **4.98 kg**.
Add ≈ 3.6 kg of electronics/motors/battery and ≈ 0.6 kg of axle, bearings, pulleys
and fasteners → **≈ 7.2 kg** as drawn, which lands inside an 8 kg class with the
aluminium base plate and would need the steel base swapped out to stay there.

## Three things I changed from the earlier spec

These were dimensional errors that only show up once the parts are solid bodies:

1. **Bulkhead height 90 → 84 mm.** It stands *on* the 6 mm base plate, so a 90 mm
   bulkhead topped out at Z=96, six millimetres above the 90 mm side skirts.
2. **Axle moved forward.** At X=235 the blade tip reached X=297.5 — 7.5 mm *behind*
   the front edge, so it could never touch an opponent. Axle is now at X=250
   (local X=105 on the bulkhead) and the blade protrudes 7.5 mm past the nose.
3. **Bulkhead taper re-cut.** The old (50,90)→(160,15) slope passed *below* the axle
   hole, so the bore had no material around it. Top flat now runs to X=120.

The forks are also modelled as flat 6 mm plates bolted under the nose rather than
45 mm-deep triangles, which would have hung below the 15 mm ground clearance.

## Assembly order

1. Cut and deburr all plates. Tap nothing yet.
2. Tack the two bulkheads to the base plate at Y=110 and Y=140, square to the floor.
   Check squareness with the axle rod slipped through both bores before full welding.
3. Tack the rear wall, then the two side skirts along the 305 mm edges.
4. Bolt the pillow blocks, slide the 10 mm axle through, fit the arbor adapter and
   the 125 mm blade centred at Y=127, then the driven pulley on the left stub.
5. Bolt the 4 Johnson motors on L-brackets so their shafts line up with the Ø14 holes
   at X=110 / X=220, Z=25. Fit Ø80 mm tyres — smaller tyres and the base plate drags.
6. Weapon motor (775, 12 V) sits on the left flank at X≈165, axis across the bot,
   belt-driving the axle stub. Centre distance ≈ 90 mm.
7. Battery flat in the rear bay (X 10–104), electronics stack at X 106–142.
8. Rivet 20 × 20 L-angle inside the top of the skirts, tap M4, screw the top and
   nose covers down. Never weld the top shut.

## Wiring note

Parallel the two left motors onto one IBT-2 and the two right onto a second — each
module handles 43 A and a Johnson 500 RPM stalls around 5–10 A. That frees two
drivers and a lot of wiring space. Buck converter 12 V → 5 V for the ESP32; weapon
ESC on its own fused feed straight from the battery with the master switch upstream
of everything.

## Update — real component dimensions (replacing earlier placeholders)

| Component | Dimension used | Source |
|---|---|---|
| 12V 7Ah SLA battery | 151 × 65 × 94 mm | Confirmed across multiple manufacturer datasheets (Magnavolt, BatteryMart, B.B. Battery) — matches what was already in the model, no change. |
| Johnson 12V DC 500 RPM motor | Gearbox Ø37mm, body Ø28.5mm, body length 63mm, 6mm shaft | Manufacturer/reseller spec sheets (Probots, REES52, Aryabot) |
| Motor L-clamp bracket | 40 × 22 mm flange, 3mm mounting holes | Robu.in "Johnson Gear Motor L Clamp" — the actual bracket sold for this motor |

**Still assumed:** the exact hole-to-hole pitch on the bracket's chassis flange (sellers list flange size, not hole spacing). Used 40mm between the two clamps, 31mm between each clamp's hole pair — reasonable for a 37mm motor, but measure your actual bracket before drilling if you want certainty.

**Still placeholder:** pillow block bolt spacing, weapon axle diameter, blade arbor adapter dimensions.

**Base plate hole pattern changed:** now 8 holes per motor position (2 clamps × 2 holes, 31mm apart), replacing the earlier generic 4-hole guess. All files in this kit have been regenerated with this pattern.

## Update — motor clamp holes set to exact 3mm

Changed from 3.4mm (M3 clearance) to **3.0mm exact**, per your bracket's spec sheet. Note this is a tight/interference fit for an M3 screw — if the screws don't slip through cleanly after cutting (paint thickness, minor laser kerf variance, etc.), that's expected; a quick pass with a 3.2mm drill bit will free it up without needing to re-cut the plate.

## Update — blade bore corrected to 20mm

Blade spec confirmed: **Ø124mm, 20mm bore**. This changed the weapon axle from 10mm to **20mm diameter** to match — a 10mm axle would have left a 10mm gap all around inside the blade, unusable.

**Pillow block bearings**: I assumed a *compact* 20mm-bore pillow block (~52mm bolt spacing, M6 bolts). This matters because the industrial-standard version (UCP204) is 127mm long with 95mm bolt spacing — nearly as long as the entire 160mm bulkhead plate, and won't fit this chassis. **Confirm your actual bearing's bolt spacing before cutting the bulkheads** — if it's not close to 52mm, tell me the real number and I'll update the model.

Still unconfirmed: blade thickness/kerf (the "(4)" figure) — please clarify whether that's thickness in mm, tooth count, or something else.

## Blade spec — confirmed from packaging photo

**BIPICO TCT Circular Saw, Ø125mm, Bore 20.0mm, 40 teeth, max 12000 RPM, wood-cutting grade.**
The earlier "124mm" was a misread of the product code "(4)" — corrected to the real 125mm.

## Every dimension re-verified against source geometry (Sept 2026)

All 7 flat cutting DXFs were checked programmatically against their intended dimensions — every one matches to within 0.1mm:

| File | Size (mm) |
|---|---|
| 1_BASE_PLATE.dxf | 305.00 × 254.00 |
| 2_SIDE_PANEL_x2.dxf | 305.00 × 90.00 |
| 3_BULKHEAD_x2.dxf | 160.00 × 84.00 |
| 4_REAR_WALL.dxf | 254.00 × 65.00 |
| 5_GROUND_FORK_x2.dxf | 120.00 × 45.00 |
| 6_TOP_COVER_x2.dxf | 140.00 × 118.00 |
| 7_NOSE_COVER_x2.dxf | 166.43 × 118.00 |

## STL vs DXF — use the right one for your CNC process

- **`dxf/` folder = for sheet-metal cutting** (laser, plasma, waterjet). This is what a combat-robot chassis actually needs — flat profiles cut from sheet stock. **Send these to your fabricator.**
- **`stl/` folder = for 3D printing or 3-axis milling from solid stock.** Only relevant if you're literally CNC-machining these parts out of a solid block rather than cutting them from sheet metal — unusual and wasteful for flat plates like these, but included since it was requested. Every STL's bounding box has been verified to match its DXF counterpart exactly.

If your "CNC cutting" is actually a laser/plasma/waterjet table (by far the standard method for this kind of chassis), use the DXFs, not the STLs.

## Update — bearing bolt spacing made editable, blade still needs replacing

**Bearing bolt spacing** was hardcoded (79mm / 131mm either side of the 20mm bore,
i.e. 52mm apart). It's now a single named variable, `BEARING_BOLT_SPACING`, near the
top of `stormhammer.scad`. Measure your actual pillow block's hole-to-hole distance
and change that one number — everything downstream (bulkhead DXF, STL) regenerates
from it. Do this before cutting the bulkheads; there's nothing else in the file to
change for this.

**Blade** — no dimensional change made, and none is needed here: the chassis, axle
(20mm) and bore (20mm) stay correct for a 125mm disc regardless of what it's cut
from. What needs to change is the blade itself, not the model. Replace the BIPICO
TCT wood-cutting blade with a one-piece disc (no brazed/welded teeth) waterjet or
laser cut from HARDOX 400/500, EN31, or D2 steel, 6-8mm thick, same 125mm OD /
20mm bore so it drops straight onto the existing axle. Most combat teams in India
get this custom-cut rather than buying off-the-shelf — a local waterjet/laser shop
that already cuts your chassis plates can usually cut the blade blank too.

## Update — axle preview corrected to 20mm

The reference axle shown in the 3D preview was still 10mm — left over from before
the bore was widened to 20mm to match the blade. Now set to 20mm to match the
bulkhead bore. Cosmetic fix only; no cutting file changed.

## Update — all 7 plates switched to aluminium

Base plate, side panels, bulkheads, rear wall, and ground forks all changed from
steel to Aluminium 6061-T6, matching the top and nose covers. Frame mass drops to
roughly **1.71 kg** (per the earlier all-aluminium weight estimate), leaving much
more of the 8kg class budget for the weapon system.

Builder is adding wood reinforcement at the bulkheads and forks to compensate for
aluminium's lower impact durability at these load-bearing points. Note: wood
resists bending/stiffening loads well but does not absorb sudden impact/shock the
way steel does — it tends to fracture rather than deform. Worth checking your
event's rulebook for any restriction on non-metal structural reinforcement before
the build is finalised.

## Update — STEP files added

A `step/` folder has been added with a true solid-body `.step` file for each of
the 7 plates, plus `STORMHAMMER_ASSEMBLY.step` combining all of them at their
correct relative positions. These are real CAD solids (exact circular holes,
exact flat faces) generated directly from the same coordinates as the DXFs and
STLs — not a mesh conversion — so they open cleanly in Fusion 360, SolidWorks,
FreeCAD, Onshape, or any other STEP-compatible CAD package.

## Update — base plate thinned to 3mm + bulkhead doubler plate added

Base plate changed from 6.0mm to 3.0mm to save weight. To compensate at the one
location that actually takes real load — the bulkhead mounting area, where the
axle and blade forces transfer into the base plate — a new part,
`8_BULKHEAD_DOUBLER.dxf`, has been added. It's a 160 x 65mm, 3mm aluminium plate
that bolts to the underside of the base plate using the SAME six bulkhead
mounting holes, effectively making that one zone 6mm thick (base + doubler
stacked) without adding weight anywhere else on the chassis.

Assembly: bolt the doubler to the underside of the base plate first (through
the six 5.5mm holes at X=160/210/260, Y=112/142), then mount the bulkheads on
top of the base plate through the same six holes, so all three layers
(bulkhead - base plate - doubler) are clamped together by the same bolts.

Ground forks are unchanged, still 6.0mm — these take direct ground/ramming
impact and were intentionally not thinned.

A matching `8_BULKHEAD_DOUBLER.step` has been added to the step/ folder, and
the assembly STEP has been regenerated to include it.

## Update — AutoCAD-ready 3D DXF files (v2)

- `stormhammer_full_assembly_3d.dxf` (new, in the root): the WHOLE bot in one file —
  plates, blade, axle, wheels, Johnson motors, 775 weapon motor, battery and electronics
  block — one layer per part. In AutoCAD: File > Open. Units are mm.
- `dxf_3d/` regenerated: the earlier files wrote 3D faces with non-standard coordinate
  group codes (10/30/50) that AutoCAD can reject. They now use the standard 10/20/30 codes.
- The bulkhead doubler is not part of the STL meshes; use `dxf/8_BULKHEAD_DOUBLER.dxf`
  or `step/8_BULKHEAD_DOUBLER.step` for it.
