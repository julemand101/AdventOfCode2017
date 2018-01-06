// --- Day 20: Particle Swarm ---
// https://adventofcode.com/2017/day/20

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day20.dart';

const String DATA_FILE_PATH = "test/data/day20.txt";

final List<String> EXAMPLE = [
  "p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>",
  "p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>"
];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(0));
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
}
