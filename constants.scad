//////////////////////////////////////////////////////////////////////
// LibFile: constants.scad
//   Useful Constants.
// Includes:
//   include <BOSL2/std.scad>
//////////////////////////////////////////////////////////////////////


// Section: General Constants

// Constant: $slop
// Description:
//   A number of printers, particularly FDM/FFF printers, tend to be a bit sloppy in their printing.
//   This has made it so that some parts won't fit together without adding a bit of extra slop space.
//   That is what the `$slop` value is for.  The value for this will vary from printer to printer.
//   By default, we use a value of 0.00 so that parts should fit exactly for resin and other precision
//   printers.  This value is measured in millimeters.  When making your own parts, you should add
//   `$slop` to both sides of a hole that another part is to fit snugly into. For a loose fit, add
//   `2*$slop` to each side.  This should be done for both X and Y axes.  The Z axis will require a
//   slop that depends on your layer height and bridging settings, and hole sizes.  We leave that as
//   a more complicated exercise for the user.
// DefineHeader(NumList): Calibration
// Calibration: To calibrate the `$slop` value for your printer, follow this procedure:
//   Print the Slop Calibration part from the example below.
//   Take the long block and orient it so the numbers are upright, facing you.
//   Take the plug and orient it so that the arrow points down, facing you.
//   Starting with the hole with the largest number in front of it, insert the small end of the plug into the hole.
//   If you can insert and remove the small end of the plug from the hole without much force, then try again with the hole with the next smaller number.
//   Repeat step 5 until you have found the hole with the smallest number that the plug fits into without much force.
//   The correct hole should hold the plug when the long block is turned upside-down.
//   The number in front of that hole will indicate the `$slop` value that is ideal for your printer.
//   Remember to set that slop value in your scripts after you include the BOSL2 library:  ie: `$slop = 0.15;`
// Example: Slop Calibration Part.
//   min_slop = 0.00;
//   slop_step = 0.05;
//   holes = 8;
//   holesize = [15,15,15];
//   height = 20;
//   gap = 5;
//   l = holes * (holesize.x + gap) + gap;
//   w = holesize.y + 2*gap;
//   h = holesize.z + 5;
//   diff("holes")
//   cuboid([l, w, h], anchor=BOT) {
//     for (i=[0:holes-1]) {
//       right((i-holes/2+0.5)*(holesize.x+gap)) {
//         s = min_slop + slop_step * i;
//         tags("holes") {
//           cuboid([holesize.x + 2*s, holesize.y + 2*s, h+0.2]);
//           fwd(w/2-1) xrot(90) linear_extrude(1.1) {
//             text(
//               text=fmt_fixed(s,2),
//               size=0.4*holesize.x,
//               halign="center",
//               valign="center",
//               font="Helvetica"
//             );
//           }
//         }
//       }
//     }
//   }
//   back(holesize.y*2.5) {
//     difference() {
//       union() {
//         cuboid([holesize.x+10, holesize.y+10, 15], anchor=BOT);
//         cuboid([holesize.x, holesize.y, 15+holesize.z], anchor=BOT);
//       }
//       up(3) fwd((holesize.y+10)/2) {
//         prismoid([holesize.x/2,1], [0,1], h=holesize.y-6);
//       }
//     }
//   }
// Example(2D): Where to add `$slop` gaps.
//   $slop = 0.2;
//   difference() {
//     square([20,12],center=true);
//     back(3) square([10+2*$slop,11],center=true);
//   }
//   back(8) {
//     rect([15,5],anchor=FWD);
//     rect([10,8],anchor=BACK);
//   }
//   color("#000") {
//     xflip_copy()
//       stroke([[5.1,6.1], [6.0,7.1], [8,7.1], [10.5,10]], width=0.3, endcap1="arrow2", endcap2="butt");
//     xcopies(21) back(10.5) {
//         back(1.8) text("$slop", size=1.5, halign="center");
//         text("gap", size=1.5, halign="center");
//     }
//   }
$slop = 0.0;


// Constant: INCH
// Description:
//   The number of millimeters in an inch.
INCH = 25.4;



// Section: Directional Vectors
//   Vectors useful for `rotate()`, `mirror()`, and `anchor` arguments for `cuboid()`, `cyl()`, etc.

// Constant: LEFT
// Description: Vector pointing left.  [-1,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=LEFT);
LEFT  = [-1,  0,  0];

// Constant: RIGHT
// Description: Vector pointing right.  [1,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=RIGHT);
RIGHT = [ 1,  0,  0];

// Constant: FRONT
// Description: Vector pointing forward.  [0,-1,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=FRONT);
FRONT = [ 0, -1,  0];

// Constant: BACK
// Description: Vector pointing back.  [0,1,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BACK);
BACK  = [ 0,  1,  0];

// Constant: BOTTOM
// Description: Vector pointing down.  [0,0,-1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BOTTOM);
BOTTOM  = [ 0,  0, -1];

// Constant: TOP
// Description: Vector pointing up.  [0,0,1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=TOP);
TOP = [ 0,  0,  1];

// Constant: ALLPOS
// Description: Vector pointing right, back, and up.  [1,1,1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=ALLPOS);
ALLPOS = [ 1,  1,  1];  // Vector pointing X+,Y+,Z+.

// Constant: ALLNEG
// Description: Vector pointing left, forwards, and down.  [-1,-1,-1]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=ALLNEG);
ALLNEG = [-1, -1, -1];  // Vector pointing X-,Y-,Z-.

// Constant: CENTER
// Description: Zero vector.  Centered.  [0,0,0]
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=CENTER);
CENTER = [ 0,  0,  0];  // Centered zero vector.


// Section: Vector Aliases
//   Useful aliases for use with `anchor`.

// Constant: CTR
// Description: Zero vector.  Centered.  `[0,0,0]`.  Alias to `CENTER`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=CTR);
CTR     = CENTER;

// Constant: UP
// Description: Vector pointing up.  [0,0,1]  Alias to `TOP`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=UP);
UP      = TOP;     // Vector pointing up, alias to `TOP`.

// Constant: DOWN
// Description: Vector pointing down.  [0,0,-1]  Alias to `BOTTOM`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=DOWN);
DOWN    = BOTTOM;  // Vector pointing down, alias to `BOTTOM`.

// Constant: BTM
// Description: Vector pointing down.  [0,0,-1]  Alias to `BOTTOM`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BTM);
BTM     = BOTTOM;  // Vector pointing down, alias to `BOTTOM`.

// Constant: BOT
// Description: Vector pointing down.  [0,0,-1]  Alias to `BOTTOM`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=BOT);
BOT     = BOTTOM;  // Vector pointing down, alias to `BOTTOM`.

// Constant: FWD
// Description: Vector pointing forward.  [0,-1,0]  Alias to `FRONT`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=FWD);
FWD     = FRONT;   // Vector pointing forward, alias to `FRONT`.

// Constant: FORWARD
// Description: Vector pointing forward.  [0,-1,0]  Alias to `FRONT`.
// Example(3D): Usage with `anchor`
//   cuboid(20, anchor=FORWARD);
FORWARD = FRONT;   // Vector pointing forward, alias to `FRONT`.


// vim: expandtab tabstop=4 shiftwidth=4 softtabstop=4 nowrap
