include <./const.scad>

// @example
support(SUPPORT_WIDTH, SWITCH_HEIGHT / 2, 35, -30, 2);

module support(
  supportWidth,
  backHeigh,
  prolongationHeight,
  rotationAngle,
  backDepth,
  compensation = 30
) {

  supportDepth = 10;
  supportHeight = sin(180 - 90 - abs(rotationAngle)) * ((backHeigh / 2) + prolongationHeight - backDepth);
  foo = cos(abs(rotationAngle)) * supportDepth / sin(abs(rotationAngle)); // TODO: find a better name

  bar = cos(180 - 90 - abs(rotationAngle)) * ((backHeigh / 2) + prolongationHeight - backDepth) + cos(abs(rotationAngle)) * backDepth; // TODO: find a better name

  translate([ 0, bar, 0 ])
  polyhedron(
    [
      [ 0, compensation, 0 ], // 0
      [ supportWidth, compensation, 0 ], // 1
      [ supportWidth, supportDepth + compensation, 0 ], // 2
      [ 0, supportDepth + compensation, 0 ], // 3
      [ 0, 0, supportHeight ], // 4
      [ supportWidth, 0, supportHeight ], // 5
      [ supportWidth, supportDepth, supportHeight + foo ], // 6
      [ 0, supportDepth, supportHeight + foo ], // 7
    ],
    [
      [ 0, 1, 2, 3 ],
      [ 4, 5, 6, 7 ],
      [ 0, 4, 5, 1 ],
      [ 3, 2, 6, 7 ],
      [ 0, 3, 7, 4 ],
      [ 1, 2, 6, 5 ],
    ]
  );

}
