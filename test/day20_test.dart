// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day20.dart';

const String DATA_FILE_PATH = "test/data/day20.txt";

final List<String> EXAMPLE_PART_ONE = [
  "p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>",
  "p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>"
];

final List<String> EXAMPLE_PART_TWO = [
  "p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>",
  "p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>",
  "p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>",
  "p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>"
];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE_PART_ONE), equals(0));
    });
    test('Solution', () {
      expect(
          solveA(new File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(170));
    });
  });

  group("Part Two", () {
    test('Example 1', () {
      expect(solveB(EXAMPLE_PART_TWO), equals(1));
    });
    test('Solution', () {
      expect(
          solveB(new File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(571));
    });
  });
}
