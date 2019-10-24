// --- Day 14: Disk Defragmentation ---
// https://adventofcode.com/2017/day/14

import 'package:AdventOfCode2017/day10.dart' as knothash;

final int CODEUNIT_1 = "1".codeUnitAt(0);

int solveA(String input) {
  int result = 0;

  for (int i = 0; i < 128; i++) {
    result += BigInt.parse(knothash.solveB("$input-$i"), radix: 16)
        .toRadixString(2)
        .codeUnits
        .where((x) => x == CODEUNIT_1)
        .length;
  }

  return result;
}

int solveB(String input) {
  final list = List.generate(128, (index) {
    return BigInt.parse(knothash.solveB("$input-$index"), radix: 16)
        .toRadixString(2)
        .padLeft(128, "0")
        .codeUnits
        .map((value) => value == CODEUNIT_1)
        .toList(growable: false);
  }, growable: false);

  int regions = 0;

  for (int x = 0; x < list.length; x++) {
    for (int y = 0; y < list[x].length; y++) {
      if (list[x][y]) {
        regions++;
        _deleteRegion(x, y, list);
      }
    }
  }

  return regions;
}

void _deleteRegion(int x, int y, List<List<bool>> list) {
  if (list[x][y]) {
    list[x][y] = false;

    _deleteRegion(_check(x + 1), _check(y), list);
    _deleteRegion(_check(x - 1), _check(y), list);
    _deleteRegion(_check(x), _check(y + 1), list);
    _deleteRegion(_check(x), _check(y - 1), list);
  }
}

int _check(int coordinate) {
  if (coordinate < 0) {
    return 0;
  } else if (coordinate > 127) {
    return 127;
  } else {
    return coordinate;
  }
}
