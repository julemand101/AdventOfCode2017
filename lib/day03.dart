// --- Day 3: Spiral Memory ---
// https://adventofcode.com/2017/day/3

import 'dart:math';

int solveA(int input) {
  if (input == 1) {
    return 0;
  }

  /* Example of box:
    65  64  63  62  61  60  59  58  57
    66  37  36  35  34  33  32  31  56
    67  38  17  16  15  14  13  30  55
    68  39  18   5   4   3  12  29  54
    69  40  19   6   1   2  11  28  53
    70  41  20   7   8   9  10  27  52
    71  42  21  22  23  24  25  26  51
    72  43  44  45  46  47  48  49  50
    73  74  75  76  77  78  79  80  81

    boxSize = the total width of the box required to store the input value.
    minNumberBox = the smallest number in the outer box
    travelFromCenter = the distance between center to edge in a straight line
   */

  final boxSize = _getBoxSize(input);
  final minNumberBox = (pow(boxSize - 2, 2)).toInt() + 1;
  final travelFromCenter = (boxSize / 2).floor();

  /* Example of distance map of the outermost edge in previous example:
                50 51 52 53 54 55 56 57
                58 59 60 61 62 63 64 65
                66 67 68 69 70 71 72 73
                74 75 76 77 78 79 80 81
                -----------------------
      Distance:  3  2  1  0  1  2  3  4

     Because we use "Manhattan Distance" we need to add some distance if we
     cannot travel in a direct line. This maap is used to the what value we
     need to add to the  travelFromCenter variable to get the total travel
     distance.

     There are always 4 lines in the map (because we have four sides of the box)
     but we need to calculate the number of columns.
   */

  final columnsInDistanceMap = travelFromCenter * 2;

  // Calculate which column our input is in the distance map.
  final xPositionInDistanceMap = (input - minNumberBox) % columnsInDistanceMap;

  // Get the distance we need to add to the travelFromCenter value.
  final extraDistance = ((travelFromCenter - 1) - xPositionInDistanceMap).abs();

  return travelFromCenter + extraDistance;
}

int _getBoxSize(int input) {
  final size = sqrt(input).ceil();
  return (size % 2 == 0) ? size + 1 : size;
}

int solveB(int input) {
  final memory = <Point<int>, int>{};

  // Start position
  var position = const Point(0, 0);

  // Initial value
  _setValue(memory, position, 1);

  while (_getValueByTuple(memory, position) < input) {
    position = _getNextStep(memory, position);
    _setValue(memory, position, _get3x3AreaSum(memory, position));
  }

  return _getValueByTuple(memory, position);
}

Point<int> _getNextStep(Map<Point<int>, int> memory, Point<int> pos) {
  final x = pos.x;
  final y = pos.y;

  final north = _getValue(memory, x, y + 1) != 0;
  final west = _getValue(memory, x - 1, y) != 0;
  final east = _getValue(memory, x + 1, y) != 0;
  final south = _getValue(memory, x, y - 1) != 0;

  if ((!north && !west && !east && !south) || (north && !south && !east)) {
    return Point(x + 1, y); // east
  }

  if (!north && west) {
    return Point(x, y + 1); // north
  }

  if (!west && south) {
    return Point(x - 1, y); // west
  }

  if (east && !south) {
    return Point(x, y - 1); // south
  }

  throw Exception('This should never happen!');
}

int _get3x3AreaSum(Map<Point<int>, int> memory, Point<int> pos) {
  final centerX = pos.x;
  final centerY = pos.y;

  return _getValue(memory, centerX - 1, centerY + 1) +
      _getValue(memory, centerX, centerY + 1) +
      _getValue(memory, centerX + 1, centerY + 1) +
      _getValue(memory, centerX - 1, centerY) +
      _getValue(memory, centerX, centerY) +
      _getValue(memory, centerX + 1, centerY) +
      _getValue(memory, centerX - 1, centerY - 1) +
      _getValue(memory, centerX, centerY - 1) +
      _getValue(memory, centerX + 1, centerY - 1);
}

int _getValue(Map<Point<int>, int> memory, int x, int y) {
  final key = Point(x, y);
  return memory[key] ?? 0;
}

int _getValueByTuple(Map<Point<int>, int> memory, Point<int> key) {
  return memory[key] ?? 0;
}

void _setValue(Map<Point<int>, int> memory, Point<int> pos, int value) {
  if (memory.containsKey(pos)) {
    throw Exception('Trying to write $value in $pos');
  }
  memory[pos] = value;
}
