// --- Day 23: Coprocessor Conflagration ---
// https://adventofcode.com/2017/day/23

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day23.dart';

const String DATA_FILE_PATH = 'test/data/day23.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(
          solveA(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(3025));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(
          solveB(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(915));
    });
  });
}
