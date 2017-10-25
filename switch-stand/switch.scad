include <./const.scad>

switch();

module switch() {

  r = 3;
  h = 1;

  translate([ 0, r, r ])
  minkowski() {

    cube([ SWITCH_WIDTH - h, SWITCH_DEPTH - (r * 2), SWITCH_HEIGHT - (r * 2) ]);

    $fn = 45;
    rotate([ 0, 90, 0 ])
    cylinder(r = r, h = h);
  }

}
