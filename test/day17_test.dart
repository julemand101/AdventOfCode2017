// --- Day 17: Spinlock ---
// https://adventofcode.com/2017/day/17

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day17.dart';

const PUZZLE_INPUT = 370;

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(3), equals(638));
    });
    test('Solution', () {
      expect(solveA(PUZZLE_INPUT), equals(1244));
    });
  });

  group("Part Two", () {
    test('Solution', () {
      expect(solveB(PUZZLE_INPUT), equals(11162912));
    });
  });
}
