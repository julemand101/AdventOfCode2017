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
}

List<String> _getPrograms(int length) {
  return new List.generate(
      length, (x) => new String.fromCharCode(CODEUNIT_FOR_LETTER_SMALL_A + x),
      growable: false);
}
