// --- Day 10: Knot Hash ---
// https://adventofcode.com/2017/day/10

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day10.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA([3, 4, 1, 5], List.generate(5, (x) => x)), equals(12));
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
          ], List.generate(256, (x) => x)),
          equals(62238));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(''), equals('a2582a3a0e66e6e86e3812dcb672a272'));
    });
    test('Example 2', () {
      expect(solveB('AoC 2017'), equals('33efeb34ea91902bb2f59c9920caa6cd'));
    });
    test('Example 3', () {
      expect(solveB('1,2,3'), equals('3efbe78a8d82f29979031a4aa0b16a9d'));
    });
    test('Example 4', () {
      expect(solveB('1,2,4'), equals('63960835bcdc130f0b66d7ff4f6a5a8e'));
    });
    test('Solution', () {
      expect(solveB('157,222,1,2,177,254,0,228,159,140,249,187,255,51,76,30'),
          equals('2b0c9cc0449507a0db3babd57ad9e8d8'));
    });
  });
}
