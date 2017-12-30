// --- Day 15: Dueling Generators ---
// https://adventofcode.com/2017/day/15

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day15.dart';

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(65, 8921), equals(588));
    });
    test('Solution', () {
      // Generator A starts with 289
      // Generator B starts with 629
      expect(solveA(289, 629), equals(638));
    });
  });

  group("Part Two", () {
    test('Example 1', () {
      expect(solveB(65, 8921), equals(309));
    });
    test('Solution', () {
      // Generator A starts with 289
      // Generator B starts with 629
      expect(solveB(289, 629), equals(343));
    });
  });
}
