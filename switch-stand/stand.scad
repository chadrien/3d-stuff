include <./const.scad>

use <./switch.scad>
use <./back.scad>
use <../utils/libtoolwall/primitives/distributeChildren.scad>

stand();

// rotate([ -45, 0, 0 ])
// cube(100);

module stand() {

  baseHeight = 2;

  backDepth = 2;

  gripWidth = 20;
  gripHeight = 10;
  gripDepth = 2;

  backProlongationHeight = 25;

  rotationAngle = -30;

  afterRotationHeightCompensation = cos(90 - abs(rotationAngle)) * backDepth;
  // afterRotationHeightCompensation = 0;
  echo(afterRotationHeightCompensation);

  translate([ 0, 0, afterRotationHeightCompensation ])
  rotate([ rotationAngle, 0, 0 ])
  translate([ 0, -(SWITCH_DEPTH + DOCK_SLIT_DEPTH + gripDepth), backProlongationHeight ]) {

    // base
    cube([ SWITCH_WIDTH, SWITCH_DEPTH + DOCK_SLIT_DEPTH + gripDepth + backDepth, baseHeight ]);

    // grips
    translate([ 0, 0, baseHeight ])
    distributeChildren(
      alongX = SWITCH_WIDTH,
      childX = gripWidth,
      paddingX = SWITCH_WIDTH / 3 - gripWidth / 2
    ) {
      cube([ gripWidth, gripDepth, gripHeight ]);
      cube([ gripWidth, gripDepth, gripHeight ]);
    }

    // back
    translate([ 0, SWITCH_DEPTH + backDepth, baseHeight ])
    back(backDepth);

    // back prolongation
    translate([ 0, SWITCH_DEPTH + backDepth + gripDepth, -backProlongationHeight ])
    cube([ SWITCH_WIDTH, backDepth, backProlongationHeight ]);

  }

}
