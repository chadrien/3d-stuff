include <./const.scad>

use <./back.scad>
use <./prolongation.scad>
use <../utils/libtoolwall/primitives/distributeChildren.scad>

// @example
rotate([ 30 - 90, 0, 0 ])
mainStructure(2, 25, -30);

module mainStructure(
  backDepth,
  backProlongationHeight,
  rotationAngle
) {

  baseHeight = 2;

  backDepth = 2;

  gripWidth = 20;
  gripHeight = 10;
  gripDepth = 2;

  backProlongationHeight = 25;

  rotationAngle = -30;

  afterRotationHeightCompensation = cos(90 - abs(rotationAngle)) * backDepth;

  usbCHoleWidth = DOCK_SLIT_WIDTH + 4;

  translate([ 0, 0, afterRotationHeightCompensation ])
  rotate([ rotationAngle, 0, 0 ])
  translate([ 0, -(SWITCH_DEPTH + DOCK_SLIT_DEPTH + gripDepth), backProlongationHeight ]) {

    // base
    difference() {

      cube([ SWITCH_WIDTH, SWITCH_DEPTH + DOCK_SLIT_DEPTH + gripDepth + backDepth, baseHeight ]);

      translate([ SWITCH_WIDTH / 2 - usbCHoleWidth / 2, -1, -1 ])
      cube([ usbCHoleWidth, SWITCH_DEPTH + gripDepth + 1, baseHeight + 2 ]);

    }

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
    prolongation(backDepth, backProlongationHeight, afterRotationHeightCompensation, rotationAngle, usbCHoleWidth);

  }

}
