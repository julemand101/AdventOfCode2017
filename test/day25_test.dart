// --- Day 25: The Halting Problem ---
// https://adventofcode.com/2017/day/25

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day25.dart';

const String DATA_FILE_PATH = 'test/data/day25.txt';

final List<String> EXAMPLE = [
  'Begin in state A.',
  'Perform a diagnostic checksum after 6 steps.',
  'In state A:',
  '  If the current value is 0:',
  '    - Write the value 1.',
  '    - Move one slot to the right.',
  '    - Continue with state B.',
  '  If the current value is 1:',
  '    - Write the value 0.',
  '    - Move one slot to the left.',
  '    - Continue with state B.',
  'In state B:',
  '  If the current value is 0:',
  '    - Write the value 1.',
  '    - Move one slot to the left.',
  '    - Continue with state A.',
  '  If the current value is 1:',
  '    - Write the value 1.',
  '    - Move one slot to the right.',
  '    - Continue with state A.',
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solve(EXAMPLE), equals(3));
    });
    test('Solution', () {
      expect(
          solve(File(DATA_FILE_PATH)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)),
          equals(4230));
    });
  });
}
