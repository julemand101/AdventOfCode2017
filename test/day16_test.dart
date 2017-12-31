// --- Day 16: Permutation Promenade ---
// https://adventofcode.com/2017/day/16

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day16.dart';

const String DATA_FILE_PATH = "test/data/day16.txt";
final int CODEUNIT_FOR_LETTER_SMALL_A = "a".codeUnitAt(0);

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(_getPrograms(5), ["s1", "x3/4", "pe/b"]), equals("baedc"));
    });
    test('Solution', () {
      expect(
          solveA(_getPrograms(16),
              new File(DATA_FILE_PATH).readAsLinesSync().first.split(",")),
          equals("dcmlhejnifpokgba"));
    });
  });

  group("Part Two", () {
    test('Example 1', () {
      expect(
          solveB(_getPrograms(5), ["s1", "x3/4", "pe/b"], 2), equals("ceadb"));
    });
    test('Example 2 (bonus)', () {
      expect(
          solveB(_getPrograms(5), ["s1", "x3/4", "pe/b"], 4), equals("abcde"));
    });
    test('Example 3 (bonus)', () {
      expect(
          solveB(_getPrograms(5), ["s1", "x3/4", "pe/b"], 0), equals("abcde"));
    });
    test('Solution', () {
      expect(
          solveB(
              _getPrograms(16),
              new File(DATA_FILE_PATH).readAsLinesSync().first.split(","),
              1000000000),
          equals("ifocbejpdnklamhg"));
    });
  });
}

List<String> _getPrograms(int length) {
  return new List.generate(
      length, (x) => new String.fromCharCode(CODEUNIT_FOR_LETTER_SMALL_A + x),
      growable: false);
}
