// --- Day 22: Sporifica Virus ---
// https://adventofcode.com/2017/day/22

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day22.dart';

const String dataFilePath = 'test/data/day22.txt';

final List<String> example = ['..#', '#..', '...'];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(example, 0), equals(0));
    });
    test('Example 2', () {
      expect(solveA(example, 1), equals(1));
    });
    test('Example 3', () {
      expect(solveA(example, 2), equals(1));
    });
    test('Example 4', () {
      expect(solveA(example, 7), equals(5));
    });
    test('Example 5', () {
      expect(solveA(example, 10000), equals(5587));
    });
    test('Solution', () {
      expect(
          solveA(
              File(dataFilePath)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              10000),
          equals(5433));
    });
  });
  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(example, 100), equals(26));
    });
    test('Example 2', () {
      expect(solveB(example, 10000000), equals(2511944));
    });
    test('Solution', () {
      expect(
          solveB(
              File(dataFilePath)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              10000000),
          equals(2512599));
    });
  });
}
