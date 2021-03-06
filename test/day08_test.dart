// --- Day 8: I Heard You Like Registers ---
// https://adventofcode.com/2017/day/8

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day08.dart';

const String DATA_FILE_PATH = 'test/data/day08.txt';

final List<String> EXAMPLE = [
  'b inc 5 if a > 1',
  'a inc 1 if b < 5',
  'c dec -10 if a >= 1',
  'c inc -20 if c == 10'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(1));
    });
    test('Solution', () {
      expect(
          solveA(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(5143));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(EXAMPLE), equals(10));
    });
    test('Solution', () {
      expect(
          solveB(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(6209));
    });
  });
}
