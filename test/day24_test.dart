// --- Day 24: Electromagnetic Moat ---
// https://adventofcode.com/2017/day/24

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day24.dart';

const String DATA_FILE_PATH = "test/data/day24.txt";

final List<String> EXAMPLE = [
  "0/2",
  "2/2",
  "2/3",
  "3/4",
  "3/5",
  "0/1",
  "10/1",
  "9/10"
];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(31));
    });
    test('Solution', () {
      expect(
          solveA(new File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(1868));
    });
  });
}
