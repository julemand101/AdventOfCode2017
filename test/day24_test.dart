// --- Day 24: Electromagnetic Moat ---
// https://adventofcode.com/2017/day/24

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day24.dart';

const String dataFilePath = 'test/data/day24.txt';

final List<String> example = [
  '0/2',
  '2/2',
  '2/3',
  '3/4',
  '3/5',
  '0/1',
  '10/1',
  '9/10'
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(example), equals(31));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(1868));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(example), equals(19));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(1841));
    });
  });
}
