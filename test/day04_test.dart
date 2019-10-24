// --- Day 4: High-Entropy Passphrases ---
// https://adventofcode.com/2017/day/4

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day04.dart';

const String DATA_FILE_PATH = 'test/data/day04.txt';

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(['aa bb cc dd ee']), equals(1)); // valid
    });
    test('Example 2', () {
      expect(solveA(['aa bb cc dd aa']), equals(0)); // invalid
    });
    test('Example 3', () {
      expect(solveA(['aa bb cc dd aaa']), equals(1)); // valid
    });
    test('Solution', () {
      expect(solveA(File(DATA_FILE_PATH).readAsLinesSync()), equals(386));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(['abcde fghij']), equals(1)); // valid
    });
    test('Example 2', () {
      expect(solveB(['abcde xyz ecdab']), equals(0)); // invalid
    });
    test('Example 3', () {
      expect(solveB(['a ab abc abd abf abj']), equals(1)); // valid
    });
    test('Example 4', () {
      expect(solveB(['iiii oiii ooii oooi oooo']), equals(1)); // valid
    });
    test('Example 5', () {
      expect(solveB(['oiii ioii iioi iiio']), equals(0)); // invalid
    });
    test('Solution', () {
      expect(solveB(File(DATA_FILE_PATH).readAsLinesSync()), equals(208));
    });
  });
}
