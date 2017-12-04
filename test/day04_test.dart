// --- Day 4: High-Entropy Passphrases ---
// http://adventofcode.com/2017/day/4

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day04.dart';

const String DATA_FILE_PATH = "test/data/day04.txt";

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(["aa bb cc dd ee"]), equals(1)); // 1 = true
    });
    test('Example 2', () {
      expect(solveA(["aa bb cc dd aa"]), equals(0)); // 0 = false
    });
    test('Example 3', () {
      expect(solveA(["aa bb cc dd aaa"]), equals(1)); // 1 = true
    });
    test('Solution', () {
      File f = new File(DATA_FILE_PATH);
      expect(solveA(f.readAsLinesSync()), equals(386));
    });
  });

//  group("Part Two", () {
//    test('Example 1', () {
//      expect(solveB(3), equals(4));
//    });
//    test('Example 2', () {
//      expect(solveB(27), equals(54));
//    });
//    test('Example 3', () {
//      expect(solveB(748), equals(806));
//    });
//    test('Solution', () {
//      expect(solveB(277678), equals(279138));
//    });
//  });
}
