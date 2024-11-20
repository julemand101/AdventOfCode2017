// --- Day 19: A Series of Tubes ---
// https://adventofcode.com/2017/day/19

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day19.dart';

const String dataFilePath = 'test/data/day19.txt';

final List<String> example = [
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
      expect(solveA(example), equals('ABCDEF'));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals('ITSZCJNMUO'));
    });
  });

  group('Part One', () {
    test('Example 1', () {
      expect(solveB(example), equals(38));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(17420));
    });
  });
}
