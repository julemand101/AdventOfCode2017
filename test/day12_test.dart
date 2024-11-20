// --- Day 12: Digital Plumber ---
// https://adventofcode.com/2017/day/12

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day12.dart';

const String dataFilePath = 'test/data/day12.txt';

final List<String> example = [
  '0 <-> 2',
  '1 <-> 1',
  '2 <-> 0, 3, 4',
  '3 <-> 2, 4',
  '4 <-> 2, 3, 6',
  '5 <-> 6',
  '6 <-> 4, 5'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(example), equals(6));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(113));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(example), equals(2));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(202));
    });
  });
}
