// --- Day 10: Knot Hash ---
// https://adventofcode.com/2017/day/10

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day10.dart';

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA([3, 4, 1, 5], new List.generate(5, (x) => x)), equals(12));
    });
    test('Solution', () {
      expect(
          solveA([
            157,
            222,
            1,
            2,
            177,
            254,
            0,
            228,
            159,
            140,
            249,
            187,
            255,
            51,
            76,
            30
          ], new List.generate(256, (x) => x)),
          equals(62238));
    });
  });

//  group("Part Two", () {
//    test('Example 1', () {
//      expect(solveB([0, 2, 7, 0]), equals(4));
//    });
//    test('Solution', () {
//      expect(solveB([0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]),
//          equals(1695));
//    });
//  });
}
