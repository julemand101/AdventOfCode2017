// --- Day 23: Coprocessor Conflagration ---
// https://adventofcode.com/2017/day/23

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day23.dart';

const String dataFilePath = 'test/data/day23.txt';

void main() {
  group('Part One', () {
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(3025));
    });
  });
  group('Part Two', () {
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(915));
    });
  });
}
