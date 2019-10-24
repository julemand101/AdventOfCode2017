// --- Day 14: Disk Defragmentation ---
// https://adventofcode.com/2017/day/14

import 'package:test/test.dart';
import 'package:AdventOfCode2017/day14.dart';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA('flqrgnkx'), equals(8108));
    });
    test('Solution', () {
      expect(solveA('ljoxqyyw'), equals(8316));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB('flqrgnkx'), equals(1242));
    });
    test('Solution', () {
      expect(solveB('ljoxqyyw'), equals(1074));
    });
  });
}
