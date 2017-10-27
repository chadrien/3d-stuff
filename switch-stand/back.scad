include <./const.scad>

use <./dockSlit.scad>
use <./prolongation.scad>

// @example
back(2);

module back(
  backDepth
) {

  backWidth = SWITCH_WIDTH;
  backHeight = SWITCH_HEIGHT / 2;

  holeDepth = backDepth;

  translate([ 0, DOCK_SLIT_DEPTH, 0 ])
  difference() {

    cube([ backWidth, backDepth, backHeight ]);

    translate([ SWITCH_WIDTH / 2 + HOLE_DISTANCE_FROM_CENTER, -1, HOLE_VERTICAL_POSITION ])
    backHole(holeDepth + 2); // above -1, and here +2 to make sure we "traverse" the surface and correctly "remove everything"

    translate([ SWITCH_WIDTH / 2 - HOLE_DISTANCE_FROM_CENTER - BACK_HOLE_WIDTH, -1, HOLE_VERTICAL_POSITION ])
    backHole(holeDepth + 2); // ^ ditto

  }

  translate([ backWidth / 2 - DOCK_SLIT_WIDTH / 2, 0, 0 ])
  dockSlit();

}

module backHole(
  holeDepth
) {

  r = floor(BACK_HOLE_HEIGHT / 2);
  h = 1;
  translate([ r, h, r ])
  minkowski() {

    cube([ BACK_HOLE_WIDTH - (r * 2), holeDepth - h, BACK_HOLE_HEIGHT - (r * 2) ]);

    $fn = 45;
    rotate([ 90, 0, 0 ])
    cylinder(r = r, h = h);

  }

}
