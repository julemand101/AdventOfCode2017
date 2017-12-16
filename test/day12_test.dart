// --- Day 12: Digital Plumber ---
// https://adventofcode.com/2017/day/12

import 'dart:io';
import 'package:test/test.dart';
import 'package:AdventOfCode2017/day12.dart';

const String DATA_FILE_PATH = "test/data/day12.txt";

final List<String> EXAMPLE = [
  "0 <-> 2",
  "1 <-> 1",
  "2 <-> 0, 3, 4",
  "3 <-> 2, 4",
  "4 <-> 2, 3, 6",
  "5 <-> 6",
  "6 <-> 4, 5"
];

void main() {
  group("Part One", () {
    test('Example 1', () {
      expect(solveA(EXAMPLE), equals(6));
    });
    test('Solution', () {
      File f = new File(DATA_FILE_PATH);
      expect(
          solveA(f.readAsLinesSync().where((line) => line.trim().isNotEmpty)),
          equals(113));
    });
  });

//  group("Part Two", () {
//    test('Solution', () {
//      File f = new File(DATA_FILE_PATH);
//      expect(
//          solveB(f
//              .readAsLinesSync()
//              .firstWhere((line) => line.trim().isNotEmpty)
//              .split(",")),
//          equals(1447));
//    });
//  });
}
