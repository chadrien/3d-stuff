include <./const.scad>

// @example
backDepth = 2;
backProlongationHeight = 25;
rotationAngle = -30;
afterRotationHeightCompensation = cos(90 - abs(rotationAngle)) * backDepth;
usbCHoleWidth = DOCK_SLIT_WIDTH + 4;
rotate([ rotationAngle, 0, 0 ])
prolongation(backDepth, backProlongationHeight, afterRotationHeightCompensation, rotationAngle, usbCHoleWidth);

module prolongation(
  backDepth,
  backProlongationHeight,
  afterRotationHeightCompensation,
  rotationAngle,
  usbCHoleWidth
) {

  difference() {

    r = 5;
    h = 1;

    hull() {

      cube([ SWITCH_WIDTH, backDepth, backProlongationHeight ]);

      baseTriangleHeight = afterRotationHeightCompensation;
      baseTriangleDepth = cos(abs(rotationAngle)) * backDepth;
      foo = sin(abs(rotationAngle)) * (baseTriangleHeight / cos(abs(rotationAngle))); // TODO find a better name
      rotate([ -rotationAngle, 0, 0 ])
      translate([ 0, 0, -afterRotationHeightCompensation ])
      polyhedron(
        [
          [ 0, -foo, 0 ], // 0
          [ SWITCH_WIDTH, -foo, 0 ], // 1
          [ SWITCH_WIDTH, baseTriangleDepth, 0 ], // 2
          [ 0, baseTriangleDepth, 0 ], // 3
          [ 0, 0, baseTriangleHeight ], // 4
          [ SWITCH_WIDTH, 0, baseTriangleHeight ], // 5
        ],
        [
          [ 0, 1, 2, 3 ],
          [ 0, 1, 5, 4 ],
          [ 0, 4, 3 ],
          [ 1, 5, 2 ],
        ]
      );

    }

    translate([ SWITCH_WIDTH / 2 - usbCHoleWidth / 2 + r, -(1 + h), 2 + r ])
    minkowski() {

      cube([ usbCHoleWidth - (r * 2), backDepth + 2 + h, backProlongationHeight - 4 - (r * 2) ]);

      $fn = 45;
      rotate([ 90, 0, 0 ])
      cylinder(r = r, h = h);

    }

    translate([ SWITCH_WIDTH / 2 - usbCHoleWidth / 2, -1, -(r + 4) ])
    cube([ usbCHoleWidth, backDepth + 2, backProlongationHeight ]);

  }

}
