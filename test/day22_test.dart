// --- Day 22: Sporifica Virus ---
// https://adventofcode.com/2017/day/22

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day22.dart';

const String DATA_FILE_PATH = "test/data/day22.txt";

final List<String> EXAMPLE = ["..#", "#..", "..."];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE, 0), equals(0));
    });
    test('Example 2', () {
      expect(solveA(EXAMPLE, 1), equals(1));
    });
    test('Example 3', () {
      expect(solveA(EXAMPLE, 2), equals(1));
    });
    test('Example 4', () {
      expect(solveA(EXAMPLE, 7), equals(5));
    });
    test('Example 5', () {
      expect(solveA(EXAMPLE, 10000), equals(5587));
    });
    test('Solution', () {
      expect(
          solveA(
              new File(DATA_FILE_PATH)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              10000),
          equals(5433));
    });
  });
  group("Part Two", () {
    test('Example 1', () {
      expect(solveB(EXAMPLE, 100), equals(26));
    });
    test('Example 2', () {
      expect(solveB(EXAMPLE, 10000000), equals(2511944));
    });
    test('Solution', () {
      expect(
          solveB(
              new File(DATA_FILE_PATH)
                  .readAsLinesSync()
                  .where((line) => line.trim().isNotEmpty)
                  .toList(growable: false),
              10000000),
          equals(2512599));
    });
  });
}
