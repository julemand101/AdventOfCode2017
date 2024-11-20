// --- Day 5: A Maze of Twisty Trampolines, All Alike ---
// https://adventofcode.com/2017/day/5

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day05.dart';

const String dataFilePath = 'test/data/day05.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA([0, 3, 0, 1, -3]), equals(5));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .map((line) => int.parse(line))
              .toList(growable: false)),
          equals(372671));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB([0, 3, 0, 1, -3]), equals(10));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .map((line) => int.parse(line))
              .toList(growable: false)),
          equals(25608480));
    });
  });
}
