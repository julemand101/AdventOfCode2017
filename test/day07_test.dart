// --- Day 7: Recursive Circus ---
// https://adventofcode.com/2017/day/7

import 'dart:io';
import 'package:test/test.dart';
import 'package:advent_of_code_2017/day07.dart';

const String dataFilePath = 'test/data/day07.txt';

final List<String> example = [
  'pbga (66)',
  'xhth (57)',
  'ebii (61)',
  'havc (66)',
  'ktlj (57)',
  'fwft (72) -> ktlj, cntj, xhth',
  'qoyq (66)',
  'padx (45) -> pbga, havc, qoyq',
  'tknk (41) -> ugml, padx, fwft',
  'jptl (61)',
  'ugml (68) -> gyxo, ebii, jptl',
  'gyxo (61)',
  'cntj (57)',
];

void main() {
  group('Part One', () {
    test('Example 1', () {
      expect(solveA(example), equals('tknk'));
    });
    test('Solution', () {
      expect(
          solveA(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals('azqje'));
    });
  });

  group('Part Two', () {
    test('Example 1', () {
      expect(solveB(example), equals(60));
    });
    test('Solution', () {
      expect(
          solveB(File(dataFilePath)
              .readAsLinesSync()
              .where((line) => line.trim().isNotEmpty)
              .toList(growable: false)),
          equals(646));
    });
  });
}
