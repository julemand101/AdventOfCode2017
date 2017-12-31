// --- Day 18: Duet ---
// https://adventofcode.com/2017/day/18

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day18.dart';

const String DATA_FILE_PATH = "test/data/day18.txt";

final List<String> EXAMPLE = [
  "set a 1",
  "add a 2",
  "mul a a",
  "mod a 5",
  "snd a",
  "set a 0",
  "rcv a",
  "jgz a -1",
  "set a 1",
  "jgz a -2"
];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(4));
    });
    test('Solution', () {
      expect(
          solveA(new File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(4601));
    });
  });
}
