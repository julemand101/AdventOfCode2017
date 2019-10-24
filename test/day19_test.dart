// --- Day 19: A Series of Tubes ---
// https://adventofcode.com/2017/day/19

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day19.dart';

const String DATA_FILE_PATH = 'test/data/day19.txt';

final List<String> EXAMPLE = [
  '     |          ',
  '     |  +--+    ',
  '     A  |  C    ',
  ' F---|----E|--+ ',
  '     |  |  |  D ',
  '     +B-+  +--+ '
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals('ABCDEF'));
    });
    test('Solution', () {
      expect(
          solveA(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals('ITSZCJNMUO'));
    });
  });

  group('Part One', () {
    test('Example 1', () {
      expect(solveB(EXAMPLE), equals(38));
    });
    test('Solution', () {
      expect(
          solveB(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(17420));
    });
  });
}
