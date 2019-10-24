// --- Day 6: Memory Reallocation ---
// https://adventofcode.com/2017/day/6

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day06.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA([0, 2, 7, 0]), equals(5));
    });
    test('Solution', () {
      expect(solveA([0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]),
          equals(7864));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB([0, 2, 7, 0]), equals(4));
    });
    test('Solution', () {
      expect(solveB([0, 5, 10, 0, 11, 14, 13, 4, 11, 8, 8, 7, 1, 4, 12, 11]),
          equals(1695));
    });
  });
}
