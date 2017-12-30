// --- Day 14: Disk Defragmentation ---
// https://adventofcode.com/2017/day/14

import 'package:AdventOfCode2017/day10.dart' as knotHash;

final CODEUNIT_1 = "1".codeUnitAt(0);

int solveA(String input) {
  int result = 0;

  for (int i = 0; i < 128; i++) {
    result += int
        .parse(knotHash.solveB("$input-$i"), radix: 16)
        .toRadixString(2)
        .codeUnits
        .where((x) => (x == CODEUNIT_1))
        .length;
  }

  return result;
}
