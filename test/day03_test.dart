// --- Day 3: Spiral Memory ---
// https://adventofcode.com/2017/day/3

import 'package:test/test.dart';
import 'package:advent_of_code_2017/day03.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(1), equals(0));
    });
    test('Example 2', () {
      expect(solveA(12), equals(3));
    });
    test('Example 3', () {
      expect(solveA(23), equals(2));
    });
    test('Example 4', () {
      expect(solveA(1024), equals(31));
    });
    test('Solution', () {
      expect(solveA(277678), equals(475));
    });
    test('Extra 1', () {
      expect(solveA(81), equals(8));
    });
    test('Extra 2', () {
      expect(solveA(57), equals(8));
    });
    test('Extra 3', () {
      expect(solveA(65), equals(8));
    });
    test('Extra 4', () {
      expect(solveA(73), equals(8));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(3), equals(4));
    });
    test('Example 2', () {
      expect(solveB(27), equals(54));
    });
    test('Example 3', () {
      expect(solveB(748), equals(806));
    });
    test('Solution', () {
      expect(solveB(277678), equals(279138));
    });
  });
}
