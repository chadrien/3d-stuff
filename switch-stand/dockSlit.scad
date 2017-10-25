include <./const.scad>

// @example
dockSlit();

module dockSlit() {

  r = 3;
  h = 1;

  translate([ r, h, r ])
  minkowski() {

    cube([ DOCK_SLIT_WIDTH - (r * 2), DOCK_SLIT_DEPTH - h, DOCK_SLIT_HEIGHT - (r * 2) ]);

    $fn = 45;
    rotate([ 90, 0, 0 ])
    cylinder(r = r, h = h);
  }

  cube([ DOCK_SLIT_WIDTH, DOCK_SLIT_DEPTH, DOCK_SLIT_HEIGHT - (r * 2) ]);

}
