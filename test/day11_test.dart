// --- Day 11: Hex Ed ---
// https://adventofcode.com/2017/day/11

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day11.dart';

const String DATA_FILE_PATH = "test/data/day11.txt";

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(["ne", "ne", "ne"]), equals(3));
    });
    test('Example 2', () {
      expect(solveA(["ne", "ne", "sw", "sw"]), equals(0));
    });
    test('Example 3', () {
      expect(solveA(["ne", "ne", "s", "s"]), equals(2));
    });
    test('Example 4', () {
      expect(solveA(["se", "sw", "se", "sw", "sw"]), equals(3));
    });
    test('Solution', () {
      File f = new File(DATA_FILE_PATH);
      expect(
          solveA(f
              .readAsLinesSync()
              .firstWhere((line) => line.trim().isNotEmpty)
              .split(",")),
          equals(664));
    });
  });

  group("Part Two", () {
    test('Solution', () {
      File f = new File(DATA_FILE_PATH);
      expect(
          solveB(f
              .readAsLinesSync()
              .firstWhere((line) => line.trim().isNotEmpty)
              .split(",")),
          equals(1447));
    });
  });
}
