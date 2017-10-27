include <./const.scad>

use <./mainStructure.scad>
use <./support.scad>

// @example
stand();

module stand() {

  backDepth = 2;
  backProlongationHeight = 25;
  rotationAngle = -30;

  mainStructure(backDepth, backProlongationHeight, rotationAngle);

  support(SUPPORT_WIDTH, SWITCH_HEIGHT / 2, backProlongationHeight, rotationAngle, backDepth);
  translate([ SWITCH_WIDTH - SUPPORT_WIDTH, 0, 0 ])
  support(SUPPORT_WIDTH, SWITCH_HEIGHT / 2, backProlongationHeight, rotationAngle, backDepth);

}
